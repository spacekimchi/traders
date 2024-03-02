//! src/routes/trade_routes.rs
//!

use actix_web::{HttpResponse ,ResponseError};
use actix_web::rt::task::JoinError;

use crate::utils::error_chain_fmt;
use crate::errors::general_errors;
    
pub use self::ExecutionError::*;

/*
 * ExecutionErrors
 * 'transparent' inside of #[error()] means it will keep original error object
 */
#[derive(thiserror::Error)]
pub enum ExecutionError {
    #[error("{0}")]
    ValidationError(String),
    #[error("Authentication failed.")]
    AuthError(#[source] anyhow::Error),
    #[error(transparent)]
    ServerError(#[from] actix_web::Error),
    #[error(transparent)]
    DatabaseError(#[from] sqlx::Error),
    #[error(transparent)]
    StoreExecutionError(#[from] StoreExecutionError),
}

impl ResponseError for ExecutionError {
    fn error_response(&self) -> HttpResponse {
        let error_message = format!("{}", self);
        let error_response = general_errors::ApiError { message: error_message };

        match self {
            ExecutionError::ValidationError(_) => HttpResponse::BadRequest().json(error_response),
            ExecutionError::AuthError(_) => HttpResponse::Unauthorized().json(error_response),
            ExecutionError::DatabaseError(_) | ExecutionError::ServerError(_) | ExecutionError::StoreExecutionError(_) => HttpResponse::InternalServerError().json(error_response),
        }
    }
}

impl std::fmt::Debug for ExecutionError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

/*
 * StoreExecutionError
 */

pub struct StoreExecutionError(pub anyhow::Error);

impl std::error::Error for StoreExecutionError {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        Some(&*self.0)
    }
}

impl std::fmt::Debug for StoreExecutionError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

impl std::fmt::Display for StoreExecutionError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "A database failure was encountered while trying to store the user."
        )
    }
}

impl From<anyhow::Error> for StoreExecutionError {
    fn from(err: anyhow::Error) -> StoreExecutionError {
        StoreExecutionError(err.into())
    }
}

impl From<sqlx::Error> for StoreExecutionError {
    fn from(err: sqlx::Error) -> StoreExecutionError {
        StoreExecutionError(err.into())
    }
}

impl From<JoinError> for StoreExecutionError {
    fn from(err: JoinError) -> StoreExecutionError {
        StoreExecutionError(anyhow::anyhow!("Spawn blocking error: {}", err))
    }
}

