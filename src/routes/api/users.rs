//! src/routes/users.rs
//!
//! Routes for actions on users
use actix_web::web::{Data, Json, Path, Form};
use actix_web::{web, HttpResponse, HttpRequest, Responder, get, post, delete};
// InternalError is similar to us returning e500;
use actix_web::error::InternalError;
use serde::{Deserialize, Serialize};
use secrecy::{Secret, ExposeSecret};

use crate::startup::AppState;
use crate::errors::*;
use crate::utils::e500;
use crate::db::models::users::{get_username, get_users_from_database, get_user_from_database, save_user_to_database, UserForm};
use crate::session_state::TypedSession;
use crate::domain::{NewUser, UserEmail, UserName};
use crate::authentication::{validate_credentials, AuthError, Credentials, change_password};
use crate::authentication::UserId;

/// This runs validations on UserForm. It tries to create the NewUser
/// for when creating a new user
impl TryFrom<UserForm> for NewUser {
    type Error = String;

    fn try_from(value: UserForm) -> Result<Self, Self::Error> {
        let username = UserName::parse(value.username)?;
        let email = UserEmail::parse(value.email)?;
        Ok(Self { email, username })
    }
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

/// This endpoint is used for grabbing the current user_id in the session
/// If there is no user in the session, it will return 0
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
    let users = get_users_from_database(&state).await.map_err(e500)?;
    Ok(HttpResponse::Ok().content_type("application/json").json(users))
}

#[tracing::instrument(
    name = "Creating a new user",
    skip(state, body, _session),
    fields(
        email = %body.email,
        username = %body.username,
    )
)]
#[post("/users")]
pub async fn create_user(
    state: Data<AppState>,
    body: Form<UserForm>,
    _session: TypedSession,
    request: HttpRequest
) -> Result<HttpResponse, InternalError<StoreUserError>> {
    match save_user_to_database(&state, &body).await {
        Ok(user) => {
            Ok(HttpResponse::Created().json(user))
        }
        Err(e) => {
            let response  = HttpResponse::BadRequest().json("Failed to create user");
            Err(InternalError::from_response(e, response))
        }
    }
}

#[get("/users/{user_id}")]
pub async fn get_user_by_id(state: Data<AppState>, path: Path<String>) -> impl Responder {
    // TODO: Get user by ID. This will discard query params
    let user_id = path.into_inner();
    match get_user_from_database(&state, &user_id).await
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

/// TODO
///   - We need some kind of password strength checker
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
    todo!();
}

