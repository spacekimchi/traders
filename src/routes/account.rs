use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Path};
use actix_web::{HttpResponse, HttpRequest, Responder, get};
use sqlx::{self, FromRow};
use crate::startup::AppState;

#[derive(Deserialize, Serialize, FromRow)]
pub struct Account {
    id: i64,
    user_id: uuid::Uuid,
    name: String,
    visible: bool,
    sim: bool,
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
pub async fn list(state: Data<AppState>, request: HttpRequest) -> impl Responder {
    //let query_string = request.query_string();
    match get_accounts(&state, &request)
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
pub async fn get_accounts(state: &Data<AppState>, request: &HttpRequest) -> Result<Vec<Account>, sqlx::Error> {
    let query_string = request.query_string();
    println!("[account.rs:get_accounts] query_string: {}", query_string);
    sqlx::query_as::<_, Account>("SELECT id, user_id, name, visible, sim, created_at, updated_at FROM accounts")
        .fetch_all(&state.db)
        .await
}

#[tracing::instrument(
    name = "List account by id",
    skip(state),
)]
#[get("/accounts/{account_id}")]
pub async fn get(state: Data<AppState>, path: Path<u32>, request: HttpRequest) -> impl Responder {
    let account_id = path.into_inner();
    println!("[account.rs] get: {:?}", account_id);
    match get_accounts(&state, &request)
        .await
        {
            Ok(accounts) => HttpResponse::Ok().content_type("application/json").json(accounts),
            Err(err) => HttpResponse::NotFound().json(format!("Error: {err}")),
        }
}
