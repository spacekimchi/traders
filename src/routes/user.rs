use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Json, Path};
use actix_web::{web, HttpResponse, HttpRequest, Responder, get, post, delete};
use sqlx::{self, FromRow};
use crate::startup::AppState;
use secrecy::Secret;
use crate::session_state::TypedSession;
use crate::utils::e500;
use anyhow::Context;
use crate::domain::{NewUser, UserEmail, UserName};
use actix_web::ResponseError;
use secrecy::ExposeSecret;
use actix_web::http::{StatusCode, header};
use actix_web::http::header::HeaderValue;
use crate::authentication::{validate_credentials, AuthError, Credentials, compute_password_hash};
use crate::routes::trade::get_username;
use actix_web::error::InternalError;
use crate::telemetry::spawn_blocking_with_tracing;
use uuid::Uuid;
use crate::authentication::UserId;

impl TryFrom<UserRequest> for NewUser {
    type Error = String;

    fn try_from(value: UserRequest) -> Result<Self, Self::Error> {
        let username = UserName::parse(value.username)?;
        let email = UserEmail::parse(value.email)?;
        Ok(Self { email, username })
    }
}

#[derive(thiserror::Error)]
pub enum UserError {
    #[error("{0}")]
    ValidationError(String),
    #[error("Authentication failed.")]
    AuthError(#[source] anyhow::Error),
    #[error(transparent)]
    UnexpectedError(#[from] anyhow::Error),
}

impl ResponseError for UserError {
    fn error_response(&self) -> HttpResponse {
        match self {
            UserError::ValidationError(_) => HttpResponse::new(StatusCode::BAD_REQUEST),
            UserError::AuthError(_) => {
                let mut response = HttpResponse::new(StatusCode::UNAUTHORIZED);
                let header_value = HeaderValue::from_str(r#"Basic realm="user""#)
                    .unwrap();
                response
                    .headers_mut()
                    .insert(header::WWW_AUTHENTICATE, header_value);
                response
            },
            UserError::UnexpectedError(_) => HttpResponse::new(StatusCode::INTERNAL_SERVER_ERROR),
        }
    }
}

pub fn error_chain_fmt(
    e: &impl std::error::Error,
    f: &mut std::fmt::Formatter<'_>,
) -> std::fmt::Result {
    writeln!(f, "{}\n", e)?;
    let mut current = e.source();
    while let Some(cause) = current {
        writeln!(f, "Caused by:\n\t{}", cause)?;
        current = cause.source();
    }
    Ok(())
}

impl std::fmt::Debug for UserError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct User {
    pub id: uuid::Uuid,
    pub visible: bool,
    pub username: String,
    pub password_hash: String,
    pub email: String,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

#[derive(Debug, Deserialize)]
pub struct UserRequest {
    pub username: String,
    pub email: String,
    pub password: Secret<String>,
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
pub async fn current_user(session: TypedSession) -> Result<impl Responder, actix_web::Error> {
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
pub async fn list(state: Data<AppState>) -> impl Responder {
    match get_users(&state)
        .await
        {
            Ok(users) => {
                HttpResponse::Ok().content_type("application/json").json(users)
            },
            Err(err) => {
                HttpResponse::InternalServerError().json(format!("Failed to get users: {err}"))
            }
        }
}

#[tracing::instrument(
    name = "Grabbing users from the database",
    skip(state),
)]
pub async fn get_users(state: &Data<AppState>) -> Result<Vec<User>, sqlx::Error> {
    sqlx::query_as::<_, User>("SELECT id, username, email, visible, created_at, updated_at FROM users")
        .fetch_all(&state.db)
        .await
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
    body: Json<UserRequest>,
    request: HttpRequest,
) -> Result<HttpResponse, UserError> {
    let user = insert_user(&state, &body).await.context("Failed to commit user to the database")?;
    /*
    match insert_user(&state, &body)
        .await
        {
            Ok(user) => {
                HttpResponse::Ok().json(user)
            },
            Err(err) => {
                tracing::error!("Failed to save user to database with error: {:?}", err); /* use {:?} here for more debug info */
                HttpResponse::InternalServerError().json(format!("Failed to create user: {err}"))
            },
        }
    */
    Ok(HttpResponse::Ok().json(user))
}

#[tracing::instrument(
    name = "Saving new user in the database",
    skip(state, body),
)]
pub async fn insert_user(state: &Data<AppState>, body: &Json<UserRequest>) -> Result<User, anyhow::Error> {
    let user_id = uuid::Uuid::new_v4();
    let password = body.password.clone();
    let password_hash = spawn_blocking_with_tracing(
            move || compute_password_hash(password)
        )
        .await?
        .context("Failed to hash password")?;
    sqlx::query_as::<_, User>(
        "INSERT INTO users (id, username, email, password_hash) VALUES ($1, $2, $3, $4) RETURNING id, username, email, visible, password_hash, created_at, updated_at"
    )
    .bind(user_id)
    .bind(&body.username)
    .bind(&body.email)
    .bind(password_hash.expose_secret())
    .fetch_one(&state.db)
    .await
    .context("A database failure was encountered while trying to store the user")
}

pub struct StoreUserError(sqlx::Error);

impl std::error::Error for StoreUserError {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        Some(&self.0)
    }
}

impl std::fmt::Debug for StoreUserError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

impl std::fmt::Display for StoreUserError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "A database failure was encountered while trying to store the user."
        )
    }
}

#[get("/users/{user_id}")]
pub async fn get(state: Data<AppState>, path: Path<String>) -> impl Responder {
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
pub async fn change_password(
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
    crate::authentication::change_password(*user_id, body.new_password.clone(), &state)
        .await
        .map_err(e500)?;
    /* TODO
     * Add password strength checker
     */
    todo!();
}

async fn reject_anonymous_users(
    session: TypedSession
) -> Result<Uuid, actix_web::Error> {
    match session.get_user_id().map_err(e500)? {
        Some(user_id) => Ok(user_id),
        None => {
            let response = HttpResponse::Unauthorized().json("You are not authorized");
            let e = anyhow::anyhow!("The user has not logged in");
            Err(InternalError::from_response(e, response).into())
        }
    }
}
