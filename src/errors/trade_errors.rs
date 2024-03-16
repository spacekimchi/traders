//! src/routes/trade_routes.rs
//!

use actix_web::{HttpResponse ,ResponseError};
use actix_web::rt::task::JoinError;

use crate::utils::error_chain_fmt;
use crate::errors::general_errors;
    
pub use self::TradeError::*;

/*
 * TradeErrors
 * 'transparent' inside of #[error()] means it will keep original error object
 */
#[derive(thiserror::Error)]
pub enum TradeError {
    #[error("{0}")]
    ValidationError(String),
    #[error("Authentication failed.")]
    AuthError(#[source] anyhow::Error),
    #[error(transparent)]
    ServerError(#[from] actix_web::Error),
    #[error(transparent)]
    DatabaseError(#[from] sqlx::Error),
    #[error(transparent)]
    StoreTradeError(#[from] StoreTradeError),
}

impl ResponseError for TradeError {
    fn error_response(&self) -> HttpResponse {
        let error_message = format!("{}", self);
        let error_response = general_errors::ApiError { message: error_message };

        match self {
            TradeError::ValidationError(_) => HttpResponse::BadRequest().json(error_response),
            TradeError::AuthError(_) => HttpResponse::Unauthorized().json(error_response),
            TradeError::DatabaseError(_) | TradeError::ServerError(_) | TradeError::StoreTradeError(_) => HttpResponse::InternalServerError().json(error_response),
        }
    }
}

impl std::fmt::Debug for TradeError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

/*
 * StoreTradeError
 */

pub struct StoreTradeError(pub anyhow::Error);

impl std::error::Error for StoreTradeError {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        Some(&*self.0)
    }
}

impl std::fmt::Debug for StoreTradeError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

impl std::fmt::Display for StoreTradeError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "A database failure was encountered while trying to store the user."
        )
    }
}

impl From<anyhow::Error> for StoreTradeError {
    fn from(err: anyhow::Error) -> StoreTradeError {
        StoreTradeError(err.into())
    }
}

impl From<sqlx::Error> for StoreTradeError {
    fn from(err: sqlx::Error) -> StoreTradeError {
        StoreTradeError(err.into())
    }
}

impl From<JoinError> for StoreTradeError {
    fn from(err: JoinError) -> StoreTradeError {
        StoreTradeError(anyhow::anyhow!("Spawn blocking error: {}", err))
    }
}

