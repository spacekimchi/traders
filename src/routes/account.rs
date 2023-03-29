use serde::{Deserialize, Serialize};
use actix_web::web::Data;
use actix_web::{HttpResponse, Responder, get};
use sqlx::{self, FromRow};
use crate::startup::AppState;

#[derive(Deserialize, Serialize, FromRow)]
pub struct Account {
    id: i64,
    user_id: uuid::Uuid,
    name: String,
    visible: bool,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

#[tracing::instrument(
    name = "List accounts",
    skip(state),
)]
#[get("/accounts")]
pub async fn list(state: Data<AppState>) -> impl Responder {
    match get_accounts(&state)
        .await
        {
            Ok(accounts) => HttpResponse::Ok().content_type("application/json").json(accounts),
            Err(err) => HttpResponse::NotFound().json(format!("Error: {err}")),
        }
}

#[tracing::instrument(
    name = "Grabbing accounts from the database",
    skip(state),
)]
pub async fn get_accounts(state: &Data<AppState>) -> Result<Vec<Account>, sqlx::Error> {
    sqlx::query_as::<_, Account>("SELECT id, user_id, name, visible, created_at, updated_at FROM accounts")
        .fetch_all(&state.db)
        .await
}

