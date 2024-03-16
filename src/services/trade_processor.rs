//! This src/services/trade_processor.rs
//! This service file is for processing executions into trades.
//! Honestly I'm not sure of a good way to go about this, because there are some edge cases
//! that I haven't figured out how to deal with yet.
//!

use sqlx::{self, PgPool};

use crate::db::models::{executions, trades};
use crate::routes::api::execution_routes::ExecutionJsonData;
use crate::errors::processing_errors::ProcessingError;

/// This is the function that will process executions and trades
pub async fn process_ninja_trader_executions_and_trades(db: &PgPool, user_id: &uuid::Uuid, executions: &Vec<ExecutionJsonData>) -> Result<(), ProcessingError> {
    process_executions(db, user_id, executions).await?;
    process_trades(db, user_id).await?;
    Ok(())
}

/// This function will process executions and save them into the database.
pub async fn process_executions(db: &PgPool, user_id: &uuid::Uuid, executions: &Vec<ExecutionJsonData>) -> Result<(), ProcessingError> {
    executions::save_executions_from_ninja_trader_to_database(db, user_id, executions).await?;
    Ok(())
}

/// This function will grab all unprocessed executions and group them into trades.
/// If a trade hasn't been closed yet, it will not be saved.
/// The trades table has a column in it is_open that is supposed to keep track of this,
/// but I haven't come up with a good idea on how to handle this yet.
pub async fn process_trades(db: &PgPool, user_id: &uuid::Uuid) -> Result<(), ProcessingError> {
    let mut executions = executions::get_unprocessed_executions_for_user(db, user_id).await?;
    // We don't need to pass the user_id here because the pending executions should hold all the
    // necessary data already (user_id, account_id)
    trades::process_pending_executions_into_trades(db, &mut executions, user_id).await?;
    Ok(())
}
