//! src/errors/account_errors.rs
//!

use actix_web::{HttpResponse ,ResponseError};
use actix_web::rt::task::JoinError;

use crate::utils::error_chain_fmt;
use crate::errors::general_errors;
    
pub use self::AccountError::*;

/*
 * AccountErrors
 * 'transparent' inside of #[error()] means it will keep original error object
 */
#[derive(thiserror::Error)]
pub enum AccountError {
    #[error("{0}")]
    ValidationError(String),
    #[error("Authentication failed.")]
    AuthError(#[source] anyhow::Error),
    #[error(transparent)]
    ServerError(#[from] actix_web::Error),
    #[error(transparent)]
    DatabaseError(#[from] sqlx::Error),
    #[error(transparent)]
    StoreAccountError(#[from] StoreAccountError),
}

impl ResponseError for AccountError {
    fn error_response(&self) -> HttpResponse {
        let error_message = format!("{}", self);
        let error_response = general_errors::ApiError { message: error_message };

        match self {
            AccountError::ValidationError(_) => HttpResponse::BadRequest().json(error_response),
            AccountError::AuthError(_) => HttpResponse::Unauthorized().json(error_response),
            AccountError::DatabaseError(_) | AccountError::ServerError(_) | AccountError::StoreAccountError(_) => HttpResponse::InternalServerError().json(error_response),
        }
    }
}

impl std::fmt::Debug for AccountError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

/*
 * StoreAccountError
 */

pub struct StoreAccountError(pub anyhow::Error);

impl std::error::Error for StoreAccountError {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        Some(&*self.0)
    }
}

impl std::fmt::Debug for StoreAccountError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

impl std::fmt::Display for StoreAccountError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "A database failure was encountered while trying to store the user."
        )
    }
}

impl From<anyhow::Error> for StoreAccountError {
    fn from(err: anyhow::Error) -> StoreAccountError {
        StoreAccountError(err.into())
    }
}

impl From<sqlx::Error> for StoreAccountError {
    fn from(err: sqlx::Error) -> StoreAccountError {
        StoreAccountError(err.into())
    }
}

impl From<JoinError> for StoreAccountError {
    fn from(err: JoinError) -> StoreAccountError {
        StoreAccountError(anyhow::anyhow!("Spawn blocking error: {}", err))
    }
}

