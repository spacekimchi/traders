//! src/db/models/trade_processing_status_messages.rs
//!
//! The purpose of this file is to hold database operations relevant to the trade_processing_status_messages table

use sqlx::{self, FromRow, PgPool};
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct TradeProcessingStatusMessage {
    pub id: i32,
    pub user_id: uuid::Uuid,
    pub trade_processing_status_id: i64,
    pub message: String,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: DateTime<Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: DateTime<Utc>,
}

#[derive(Debug, Serialize)]
pub struct TradeProcessingStatusMessageToSave {
    pub user_id: uuid::Uuid,
    pub trade_processing_status_id: i64,
    pub message: String,
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct TradeProcessingStatusMessageId {
    pub id: i64,
}

/// This is for saving a message to the trade_processing_status_messages table
pub async fn save_to_db(db: &PgPool, status_message: TradeProcessingStatusMessageToSave) -> Result<i64, sqlx::Error> {
    let message_id = sqlx::query_as!(
        TradeProcessingStatusMessageId,
        "INSERT INTO trade_processing_status_messages (user_id, trade_processing_status_id, message) VALUES ($1, $2, $3) RETURNING id;",
        status_message.user_id,
        status_message.trade_processing_status_id,
        status_message.message,
        ).fetch_one(db).await?.id;

    Ok(message_id)
}
