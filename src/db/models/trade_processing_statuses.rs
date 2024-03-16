//! src/db/models/trade_processing_statuses.rs
//!
//! The purpose of this file is to hold database operations relevant to the trade_processing_statuses table

use sqlx::{self, FromRow, PgPool, Type};
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

use crate::db::models::trade_processing_status_messages;

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq, Eq, Type)]
#[sqlx(type_name = "processing_status_enum")]
pub enum ProcessingStatus {
    STARTED,
    SUCCESS,
    FAILED,
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct TradeProcessingStatus {
    pub id: i64,
    pub user_id: uuid::Uuid,
    pub processing_status: ProcessingStatus,
    pub attempted_execution_ids: Option<Vec<i64>>,
    pub failed_execution_ids: Option<Vec<i64>>,
    pub started_processing_at: DateTime<Utc>,
    pub finished_processing_at: Option<DateTime<Utc>>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TradeProcessingStatusToSave {
    pub user_id: uuid::Uuid,
    pub processing_status: ProcessingStatus,
    pub attempted_execution_ids: Option<Vec<i64>>,
    pub failed_execution_ids: Option<Vec<i64>>,
    pub started_processing_at: Option<DateTime<Utc>>,
    pub finished_processing_at: Option<DateTime<Utc>>,
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct TradeProcessingStatusId {
    pub id: i64,
}

pub async fn get_most_recent_trade_processing_status(db: &PgPool, user_id: &uuid::Uuid) -> Result<TradeProcessingStatus, sqlx::Error> {
    let query = String::from(
        format!(
"SELECT id, user_id, processing_status, attempted_execution_ids, failed_execution_ids, started_processing_at, finished_processing_at
FROM trade_processing_statuses
WHERE user_id = '{}'
ORDER BY started_processing_at DESC
LIMIT 1", user_id
));
    let trade_processing_status = sqlx::query_as::<_, TradeProcessingStatus>(&query)
        .fetch_one(db)
        .await?;

    Ok(trade_processing_status)
}

pub async fn save_to_db(db: &PgPool, trade_processing_status: &TradeProcessingStatusToSave) -> Result<TradeProcessingStatusId, sqlx::Error> {
    let trade_processing_status_id = sqlx::query_as!(
        TradeProcessingStatusId,
        "INSERT INTO trade_processing_statuses (user_id, processing_status, attempted_execution_ids, failed_execution_ids, started_processing_at, finished_processing_at) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id;",
        trade_processing_status.user_id,
        trade_processing_status.processing_status.clone() as ProcessingStatus,
        trade_processing_status.attempted_execution_ids.as_deref(),
        trade_processing_status.failed_execution_ids.as_deref(),
        trade_processing_status.started_processing_at,
        trade_processing_status.finished_processing_at,
        ).fetch_one(db).await?;

    Ok(trade_processing_status_id)
}

pub async fn start(db: &PgPool, user_id: &uuid::Uuid, attempted_execution_ids: &Vec<i64>) -> Result<TradeProcessingStatusId, sqlx::Error> {
    let trade_processing_status_id = sqlx::query_as!(
        TradeProcessingStatusId,
        "INSERT INTO trade_processing_statuses (user_id, processing_status, attempted_execution_ids) VALUES ($1, $2, $3) RETURNING id;",
        user_id,
        ProcessingStatus::STARTED as ProcessingStatus,
        attempted_execution_ids
        ).fetch_one(db).await?;

    Ok(trade_processing_status_id)
}

pub async fn end_with_success(db: &PgPool, user_id: &uuid::Uuid, trade_processing_status_id: &TradeProcessingStatusId) -> Result<(), sqlx::Error> {
    // Get the current date and time in UTC
    let current_utc_time: DateTime<Utc> = Utc::now();
    sqlx::query!(
        "UPDATE trade_processing_statuses SET processing_status = $1, finished_processing_at = $2 WHERE id = $3 AND user_id = $4",
        ProcessingStatus::SUCCESS as ProcessingStatus,
        current_utc_time,
        trade_processing_status_id.id,
        user_id,
    )
    .execute(db)
    .await?;

    Ok(())
}

pub async fn end_with_error(db: &PgPool, user_id: &uuid::Uuid, trade_processing_status_id: &TradeProcessingStatusId, failed_execution_ids: &Vec<i64>) -> Result<(), sqlx::Error> {
    // Get the current date and time in UTC
    let current_utc_time: DateTime<Utc> = Utc::now();
    sqlx::query!(
        "UPDATE trade_processing_statuses SET processing_status = $1, failed_execution_ids = $2, finished_processing_at = $3 WHERE id = $4 AND user_id = $5",
        ProcessingStatus::FAILED as ProcessingStatus,
        failed_execution_ids,
        current_utc_time,
        trade_processing_status_id.id,
        user_id,
    )
    .execute(db)
    .await?;

    Ok(())
}

/// For recording a message for the trade_processing_status
pub async fn record_message(db: &PgPool, user_id: &uuid::Uuid, trade_processing_status_id: &TradeProcessingStatusId, message: &String) -> Result<(), sqlx::Error> {
    let message_to_save = trade_processing_status_messages::TradeProcessingStatusMessageToSave {
        trade_processing_status_id: trade_processing_status_id.id,
        user_id: user_id.clone(),
        message: message.clone(),
    };
    trade_processing_status_messages::save_to_db(db, message_to_save).await?;
    return Ok(())
}
