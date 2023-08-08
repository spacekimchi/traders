use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Json, Path};
use actix_web::{web, HttpResponse, HttpRequest, Responder, get, post, delete};
use secrecy::{Secret, ExposeSecret};
// use validator::{Validate, ValidationError, ValidationErrors};
// ValidationError and ValidationErrors can be returned as the error type
// when using the .validate() method on a struct that derives the Validate macro
use validator::Validate;

use crate::db::models::User;
use crate::db::models::user::get_username;
use crate::errors::*;
use crate::session_state::TypedSession;
use crate::startup::AppState;
use crate::utils::e500;
use crate::domain::{NewUser, UserEmail, UserName};
use crate::authentication::{validate_credentials, AuthError, Credentials, compute_password_hash, change_password};
use crate::telemetry::spawn_blocking_with_tracing;
use crate::authentication::UserId;

/**
 * This runs validations on UserRequest
 */
impl TryFrom<UserRequest> for NewUser {
    type Error = String;

    fn try_from(value: UserRequest) -> Result<Self, Self::Error> {
        let username = UserName::parse(value.username)?;
        let email = UserEmail::parse(value.email)?;
        Ok(Self { email, username })
    }
}

/**
 * The Validate here is another way of running validations
 * the validate in the UserRequeset struct doesn't do anything until
 * .validate() is called
 *
 *  let user_request = UserRequest {
 *      username: "".to_string(),
 *      email: "not_an_email".to_string(),
 *      password: "short".to_string(),
 *  };
 *
 *  match user_request.validate() {
 *      Ok(_) => {
 *          // If validation passed, proceed with user creation.
 *          // Or we can return some kind of HttpInvalidRequest Error
 *          println!("User creation request is valid.");
 *      }
 *      Err(e) => {
 *          // If validation failed, print the errors.
 *          println!("User creation request validation failed: {:?}", e);
 *      }
 *  }
 */
#[derive(Debug, Deserialize, Validate)]
pub struct UserRequest {
    #[validate(length(min = 1))]
    pub username: String,
    pub email: String,
    pub password: Secret<String>,
}

#[derive(Debug, Serialize)]
pub struct UserResponse {
    pub id: uuid::Uuid,
    pub username: String,
    pub email: String,
    // other fields but no password
}

#[derive(Debug, Deserialize)]
pub struct ChangePasswordRequest {
    pub current_password: Secret<String>,
    pub new_password: Secret<String>,
    pub new_password_check: Secret<String>,
}

#[tracing::instrument(
    name = "Getting current user",
    skip(session),
)]
#[get("/current_user")]
pub async fn current_user(session: TypedSession) -> Result<HttpResponse, actix_web::Error> {
    match session
        .get_user_id()
        .map_err(e500)?
        {
            Some(user_id) => Ok(HttpResponse::Ok().content_type("application/json").json(user_id)),
            None => Ok(HttpResponse::Ok().content_type("application/json").json("0"))
        }
}

#[tracing::instrument(
    name = "Listing users",
    skip(state),
)]
#[get("/users")]
pub async fn list_users(state: Data<AppState>) -> Result<impl Responder, UserError> {
    let users = get_users(&state).await.map_err(e500)?;
    Ok(HttpResponse::Ok().content_type("application/json").json(users))
}

#[tracing::instrument(
    name = "Grabbing users from the database",
    skip(state),
)]
pub async fn get_users(state: &Data<AppState>) -> Result<Vec<User>, UserError> {
    sqlx::query_as::<_, User>("SELECT id, username, email, visible, created_at, updated_at FROM users")
        .fetch_all(&state.db)
        .await
        .map_err(UserError::DatabaseError)
}

#[tracing::instrument(
    name = "Creating a new user",
    skip(state, body),
    fields(
        email = %body.email,
        username = %body.username,
    )
)]
#[post("/users")]
pub async fn create(
    state: Data<AppState>,
    body: actix_web_validator::Json<UserRequest>,
    request: HttpRequest,
) -> Result<HttpResponse, UserError> {
    let user = insert_user(&state, &body).await?;
    let user_response = UserResponse {
        id: user.id,
        username: user.username,
        email: user.email,
        // copy other fields
    };
    Ok(HttpResponse::Ok().json(user_response))
}

#[tracing::instrument(
    name = "Saving new user in the database",
    skip(state, body),
)]
pub async fn insert_user(state: &Data<AppState>, body: &actix_web_validator::Json<UserRequest>) -> Result<User, StoreUserError> {
    let user_id = uuid::Uuid::new_v4();
    let password = body.password.clone();

    /* TODO: Study this pattern */
    let password_hash_result = spawn_blocking_with_tracing(move || compute_password_hash(password)).await;
    let password_hash = match password_hash_result {
        Ok(hash) => hash,
        Err(_) => return Err(StoreUserError(anyhow::anyhow!("Failed to hash password"))),
    };

    sqlx::query_as::<_, User>(
        "INSERT INTO users (id, username, email, password_hash) VALUES ($1, $2, $3, $4) RETURNING id, username, email, visible, password_hash, created_at, updated_at"
    )
    .bind(user_id)
    .bind(&body.username)
    .bind(&body.email)
    .bind(password_hash?.expose_secret())
    .fetch_one(&state.db)
    .await
    .map_err(|err| StoreUserError(err.into()))
}

#[get("/users/{user_id}")]
pub async fn get_user_by_id(state: Data<AppState>, path: Path<String>) -> impl Responder {
    // TODO: Get user by ID. This will discard query params
    let user_id = path.into_inner();
    match sqlx::query_as::<_, User>("SELECT id, username, email, created_at FROM users WHERE id = $1")
        .bind(user_id)
        .fetch_all(&state.db)
        .await
        {
            Ok(user) => HttpResponse::Ok().json(user),
            Err(_) => HttpResponse::NotFound().json("No user found"),
        }
}

#[delete("/users/{user_id}")]
pub async fn delete(_state: Data<AppState>, _path: Path<(String,)>) -> HttpResponse {
    // TODO: Delete user by ID
    // in any case return status 204

    HttpResponse::NoContent()
        .content_type("application/json")
        .await
        .unwrap()
}

#[post("/users/{user_id}")]
pub async fn change_user_password(
    state: Data<AppState>,
    body: Json<ChangePasswordRequest>,
    user_id: web::ReqData<UserId>,
) -> Result<HttpResponse, actix_web::Error> {
    let user_id = user_id.into_inner();
    if body.new_password.expose_secret() != body.new_password_check.expose_secret() {
        return Ok(HttpResponse::BadRequest().json("Passwords do not match"));
    }
    let username = get_username(*user_id, &state).await.map_err(e500)?;
    let credentials = Credentials {
        username,
        password: body.current_password.clone(),
    };
    if let Err(e) = validate_credentials(credentials, &state).await {
        return match e {
            AuthError::InvalidCredentials(_) => {
                Ok(HttpResponse::BadRequest().json("The current password is incorrect"))
            }
            AuthError::UnexpectedError(_) => Err(e500(e)),
        }
    }
    change_password(*user_id, body.new_password.clone(), &state)
        .await
        .map_err(e500)?;
    /* TODO
     * Add password strength checker
     */
    todo!();
}

