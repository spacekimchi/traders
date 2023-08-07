use anyhow::Context;
use sqlx::{self, FromRow};
use actix_web::web::Data;
use serde::{Deserialize, Serialize};

use crate::startup::AppState;

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

#[tracing::instrument(name = "Get username", skip(state))]
pub async fn get_username(
    user_id: uuid::Uuid, 
    state: &Data<AppState>,
) -> Result<String, anyhow::Error> {
    let row = sqlx::query!(
        r#"
        SELECT username
        FROM users
        WHERE id = $1
        "#,
        user_id,
    ) .fetch_one(&state.db)
    .await
    .context("Failed to perform a query to retrieve a username.")?;
    Ok(row.username)
}

