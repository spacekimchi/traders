//! src/routes/users.rs
//!
//! Routes for actions on users
use std::fmt::Write;

use actix_web::web::{Data, Json, Path, Form};
use actix_web::http::header::LOCATION;
use actix_web::{web, HttpResponse, HttpRequest, Responder, get, post, delete};
use actix_web_flash_messages::{FlashMessage, IncomingFlashMessages};
use actix_web::error::InternalError;
use handlebars::Handlebars;
use serde::{Deserialize, Serialize};
use serde_json::json;
use secrecy::{Secret, ExposeSecret};

use crate::errors::*;
use crate::utils::e500;
use crate::db::models::User;
use crate::db::models::user::get_username;
use crate::session_state::TypedSession;
use crate::startup::AppState;
use crate::domain::{NewUser, UserEmail, UserName};
use crate::authentication::{validate_credentials, AuthError, Credentials, compute_password_hash, change_password};
use crate::telemetry::spawn_blocking_with_tracing;
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

#[derive(Debug, Deserialize)]
pub struct UserForm {
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
    name = "New user page",
    skip(hb, flash_messages),
)]
#[get("/new")]
pub async fn new_user_page(hb: Data<Handlebars<'_>>, flash_messages: IncomingFlashMessages) -> Result<HttpResponse, actix_web::Error> {
    println!("GETTING NEW_USER_PAGE");
    let mut flash_html = String::new();
    for m in flash_messages.iter() {
        writeln!(flash_html, "<div>{}<div>", m.content()).unwrap();
    }
    //let top_nav = hb.render("partials/_top_nav", &json!({})).unwrap();
    let content = hb.render("users/new", &json!({})).unwrap();
    let data = json!({
        "content": content,
        //"top_nav": top_nav
    });
    let body = hb.render("base", &data).unwrap();

    Ok(HttpResponse::Ok().body(body))
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
    name = "Grabbing users from the database",
    skip(state),
)]
pub async fn get_users_from_database(state: &Data<AppState>) -> Result<Vec<User>, UserError> {
    sqlx::query_as::<_, User>("SELECT id, username, email, visible, created_at, updated_at FROM users")
        .fetch_all(&state.db)
        .await
        .map_err(UserError::DatabaseError)
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
    request: HttpRequest,
    hb: Data<Handlebars<'_>>,
) -> Result<HttpResponse, InternalError<StoreUserError>> {
    //let user = insert_user(&state, &body).await?;
    match insert_user(&state, &body).await {
        Ok(_user) => {
            // We need some kind of flash message to alert of a successful creation

            FlashMessage::success("User creation successful!").send();
            Ok(HttpResponse::SeeOther()
               .insert_header((LOCATION, "/"))
               .finish())
        }
        Err(e) => {
            // Needs some kind of setting errors up here
            let content = hb.render("users/new", &json!({})).unwrap();
            let data = json!({
                "content": content,
                //"create_errors": top_nav
            });
            let body = hb.render("base", &data).unwrap();

            let response = HttpResponse::BadRequest().body(body);

            return Err(InternalError::from_response(e, response));
        }
    }
    //let user_response = UserResponse {
        //id: user.id,
        //username: user.username,
        //email: user.email,
        //// copy other fields
    //};
    //Ok(HttpResponse::Created().json(user_response))
}

#[tracing::instrument(
    name = "Saving new user in the database",
    skip(state, body),
)]
pub async fn insert_user(state: &Data<AppState>, body: &Form<UserForm>) -> Result<User, StoreUserError> {
    let user_id = uuid::Uuid::new_v4();
    let password = body.0.password.clone();

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
    .bind(&body.0.username)
    .bind(&body.0.email)
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

