use actix_web::http::StatusCode;
use actix_web::HttpResponse;
use actix_web::ResponseError;
use actix_web::rt::task::JoinError;

use crate::utils::error_chain_fmt;

pub use self::UserError::*;

/*
 * UserErrors
 * 'transparent' inside of #[error()] means it will keep original error object
 */
#[derive(thiserror::Error)]
pub enum UserError {
    #[error("{0}")]
    ValidationError(String),
    #[error("Authentication failed.")]
    AuthError(#[source] anyhow::Error),
    #[error(transparent)]
    ServerError(#[from] actix_web::Error),
    #[error(transparent)]
    DatabaseError(#[from] sqlx::Error),
    #[error(transparent)]
    StoreUserError(#[from] StoreUserError),
}

impl ResponseError for UserError {
    fn error_response(&self) -> HttpResponse {
        match self {
            UserError::ValidationError(_) => HttpResponse::new(StatusCode::BAD_REQUEST),
            UserError::AuthError(_) => HttpResponse::new(StatusCode::UNAUTHORIZED),
            UserError::DatabaseError(_) => HttpResponse::new(StatusCode::INTERNAL_SERVER_ERROR),
            UserError::ServerError(_) => HttpResponse::new(StatusCode::INTERNAL_SERVER_ERROR),
            UserError::StoreUserError(_) => HttpResponse::new(StatusCode::INTERNAL_SERVER_ERROR),
        }
    }
}

impl std::fmt::Debug for UserError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

/*
 * StoreUserError
 */

pub struct StoreUserError(pub anyhow::Error);

impl std::error::Error for StoreUserError {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        Some(&*self.0)
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

impl From<anyhow::Error> for StoreUserError {
    fn from(err: anyhow::Error) -> StoreUserError {
        StoreUserError(err.into())
    }
}

impl From<sqlx::Error> for StoreUserError {
    fn from(err: sqlx::Error) -> StoreUserError {
        StoreUserError(err.into())
    }
}

impl From<JoinError> for StoreUserError {
    fn from(err: JoinError) -> StoreUserError {
        StoreUserError(anyhow::anyhow!("Spawn blocking error: {}", err))
    }
}

