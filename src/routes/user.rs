use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Json, Path};
use actix_web::{HttpResponse, HttpRequest, Responder, get, post, delete};
use sqlx::{self, FromRow};
use crate::startup::AppState;
use secrecy::Secret;
use anyhow::Context;
use base64::{Engine as _, engine::general_purpose};
use crate::domain::{NewUser, UserEmail, UserName};
use actix_web::ResponseError;
use actix_web::http::{StatusCode, header};
use actix_web::http::header::{HeaderMap, HeaderValue};
use crate::authentication::{validate_credentials, AuthError, Credentials};

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

#[derive(Debug, Deserialize, Serialize)]
pub struct UserRequest {
    pub username: String,
    pub email: String,
}

fn basic_authentication(headers: &HeaderMap) -> Result<Credentials, anyhow::Error> {
    // The header value, if present, must be a vlid UTF8 String
    println!("entering credentials");
    let header_value = headers
        .get("Authorization")
        .context("The 'Authorization' header was missing")?
        .to_str()
        .context("The 'Authorization' header was not a valid UTF8 string.")?;
    let base64encoded_segment = header_value
        .strip_prefix("Basic ")
        .context("The authorization scheme was not 'Basic'.")?;
    let decoded_bytes = general_purpose::STANDARD.decode(base64encoded_segment)
        .context("Failed to base64-decode 'Basic' credentials.")?;
    let decoded_credentials = String::from_utf8(decoded_bytes)
        .context("The decoded credential string is not valid UTF8.")?;

    // Split into two segments, using ':' as delimiter
    let mut credentials = decoded_credentials.splitn(2, ':');
    let username = credentials
        .next()
        .ok_or_else(|| anyhow::anyhow!("A username must be provided in 'Basic' auth."))?
        .to_string();
    let password = credentials
        .next()
        .ok_or_else(|| anyhow::anyhow!("A password must be provided in 'Basic' auth."))?
        .to_string();
    println!("returning credentials");

    Ok(Credentials {
        username,
        password: Secret::new(password)
    })
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
    /*
    let credentials = basic_authentication(request.headers()).map_err(UserError::AuthError)?;
    let _user_id = validate_credentials(credentials, &state)
        .await
        .map_err(|e| match e {
            AuthError::InvalidCredentials(_) => UserError::AuthError(e.into()),
            AuthError::UnexpectedError(_) => UserError::UnexpectedError(e.into()),
        })?;
    */
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
pub async fn insert_user(state: &Data<AppState>, body: &Json<UserRequest>) -> Result<User, StoreUserError> {
    let user_id = uuid::Uuid::new_v4();
    let password_hash = "asdjflsajflsfls";
    let created_at = chrono::offset::Utc::now();
    println!("creating user: ");
    sqlx::query_as::<_, User>(
        "INSERT INTO users (id, username, email, password_hash, created_at) VALUES ($1, $2, $3, $4, $5) RETURNING id, username, email, visible, password_hash, created_at, updated_at"
    )
    .bind(user_id)
    .bind(&body.username)
    .bind(&body.email)
    .bind(password_hash)
    .bind(created_at)
    .fetch_one(&state.db)
    .await
    .map_err(StoreUserError)
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

