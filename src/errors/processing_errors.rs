//! src/errors/processing_errors.rs
//! This error type is for encapsulating the ExecutionError and TradeError.
//! It is useful because then we can just use this in the functions that process trades and
//! executions
//!
use crate::errors::execution_errors::ExecutionError;
use crate::errors::trade_errors::TradeError;

#[derive(Debug, thiserror::Error)]
pub enum ProcessingError {
    #[error("Execution error: {0}")]
    Execution(#[from] ExecutionError),

    #[error("Trade error: {0}")]
    Trade(#[from] TradeError),
}

