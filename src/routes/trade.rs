use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Json, Path};
use actix_web::{HttpResponse, Responder, get, post, delete};
//use actix_web::web::Path;

use sqlx::{self, FromRow};
//use crate::response::Response;
use crate::startup::AppState;

//pub type Trades = Response<Trade>;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct Trade {
    pub id: i32,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    pub user_id: i32,
    pub shared: bool,
	pub instrument: String,
	pub action: String,
	pub quantity: i32,
	pub price: f32,
	pub time: i64,
	pub entry: bool,
	pub position: String,
	pub commission: f32,
	pub rate: i32,
	pub account_display_name: String,
	pub pnl: f32,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TradeRequest {
    pub user_id: i32,
    pub shared: bool,
	pub instrument: String,
	pub action: String,
	pub quantity: i32,
	pub price: f32,
	pub time: u32,
	pub entry: bool,
	pub position: String,
	pub commission: f32,
	pub rate: i32,
	pub account_display_name: String,
	pub pnl: f32,
}

#[get("/trades")]
pub async fn list(state: Data<AppState>) -> impl Responder {
    // TODO: get trades this will have query params "?ingredients=apple,chicken,thyme"
    match sqlx::query_as::<_, Trade>("SELECT id, user_id, shared, instrument, action, quantity, price, time, entry, position, commission, rate, account_display_name, pnl, created_at FROM trades")
        .fetch_all(&state.db)
        .await
        {
            Ok(trades) => HttpResponse::Ok().content_type("application/json").json(trades),
            Err(err) => HttpResponse::NotFound().json(format!("Error: {err}")),
        }
}

#[post("/trades")]
pub async fn create(state: Data<AppState>, body: Json<TradeRequest>) -> HttpResponse {
    let created_at = chrono::offset::Utc::now();
    match sqlx::query_as::<_, Trade>(
        "INSERT INTO trades (user_id, shared, instrument, action, quantity, price, time, entry, position, commission, rate, account_display_name, pnl, created_at) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14) RETURNING id, user_id, shared, instrument, action, quantity, price, time, entry, position, commission, rate, account_display_name, pnl, created_at"
    )
    .bind(body.user_id)
    .bind(body.shared)
    .bind(body.instrument.to_string())
    .bind(body.action.to_string())
    .bind(body.quantity)
    .bind(body.price)
    .bind(body.time as i64)
    .bind(body.entry)
    .bind(body.position.to_string())
    .bind(body.commission)
    .bind(body.rate)
    .bind(body.account_display_name.to_string())
    .bind(body.pnl)
    .bind(created_at)
    .fetch_one(&state.db)
    .await
    {
        Ok(trade) => HttpResponse::Ok().json(trade),
        Err(err) => HttpResponse::InternalServerError().json(format!("Failed to create trade: {err}")),
    }
}

#[get("/trades/{trade_id}")]
pub async fn get(state: Data<AppState>, path: Path<String>) -> impl Responder {
    // TODO: Get trade by ID. This will discard query params
    let trade_id = path.into_inner();
    match sqlx::query_as::<_, Trade>("SELECT id, user_id, shared, instrument, action, quantity, price, time, entry, position, commission, rate, account_display_name, pnl, created_at FROM trades WHERE id = $1")
        .bind(trade_id)
        .fetch_all(&state.db)
        .await
        {
            Ok(trade) => HttpResponse::Ok().json(trade),
            Err(_) => HttpResponse::NotFound().json("No trade found"),
        }
}


#[delete("/trades/{trade_id}")]
pub async fn delete(_state: Data<AppState>, _path: Path<(String,)>) -> HttpResponse {
    // TODO: Delete trade by ID
    // in any case return status 204

    HttpResponse::NoContent()
        .content_type("application/json")
        .await
        .unwrap()
}

