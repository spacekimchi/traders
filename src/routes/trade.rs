use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Json, Path};
use actix_web::{HttpResponse, Responder, get, post, delete};
use sqlx::{self, FromRow};
use crate::startup::AppState;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct Trade {
    pub id: i64,
    pub user_id: uuid::Uuid,
	pub instrument: String,
	pub action: String,
	pub quantity: i32,
	pub price: f32,
	pub time: f64,
	pub commission: f32,
	pub account_display_name: String,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TradeRequest {
    pub instrument: Vec<String>,
	pub action: Vec<String>,
	pub quantity: Vec<i32>,
	pub price: Vec<f32>,
	pub time: Vec<f64>,
	pub commission: Vec<f32>,
	pub account_display_name: Vec<String>,
}

impl std::fmt::Display for TradeRequest {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(
            f,
            "TradeFields: {:?}",
            self.instrument,
        )
    }
}


#[tracing::instrument(
    name = "Listing trades",
    skip(state),
)]
#[get("/trades")]
pub async fn list(state: Data<AppState>) -> impl Responder {
    match get_trades(&state)
        .await
        {
            Ok(trades) => HttpResponse::Ok().content_type("application/json").json(trades),
            Err(err) => HttpResponse::NotFound().json(format!("Error: {err}")),
        }
}

#[tracing::instrument(
    name = "Grabbing trades from the database",
    skip(state),
)]
pub async fn get_trades(state: &Data<AppState>) -> Result<Vec<Trade>, sqlx::Error> {
    sqlx::query_as::<_, Trade>("SELECT id, user_id, instrument, action, quantity, price, time, commission, account_display_name, created_at, updated_at from trades")
        .fetch_all(&state.db)
        .await
}

/*
 * Xlsx file will be parsed on the frontend and uploaded to the backend as a field of json.
 * Don't need to upload xlsx files to backend
 */
#[tracing::instrument(
    name = "Creating a new trade",
    skip(state, body),
    fields(
        instrument = ?body.instrument,
        action = ?body.action,
        quantity = ?body.quantity,
        price = ?body.price,
        time = ?body.time,
        commission = ?body.commission,
        account_display_name = ?body.account_display_name,
    )
)]
#[post("/trades")]
pub async fn create(state: Data<AppState>, body: Json<TradeRequest>) -> HttpResponse {
    match insert_trades(&state, &body)
        .await
        {
            Ok(trades) => HttpResponse::Ok().json(trades),
            Err(err) => HttpResponse::InternalServerError().json(format!("Failed to create trade: {err}")),
        }
}
/*
 *
	pub instrument: Vec<String>,
	pub action: Vec<String>,
	pub quantity: Vec<i32>,
	pub price: Vec<f32>,
	pub time: Vec<f64>,
	pub commission: Vec<f32>,
	pub account_display_name: Vec<String>,
 */
#[tracing::instrument(
    name = "Inserting new trades into the database",
    skip(state, body),
)]
pub async fn insert_trades(state: &Data<AppState>, body: &Json<TradeRequest>) -> Result<Vec<Trade>, sqlx::Error> {
    let user_ids = ["c894a480-b3e2-41ea-af47-e9fdd8ff4d7b", "c894a480-b3e2-41ea-af47-e9fdd8ff4d7b"];
    sqlx::query_as::<_, Trade>(
        "
            INSERT INTO trades (instrument, action, quantity, price, time, commission, account_display_name, user_id)
            SELECT * FROM UNNEST($1::text[], $2::text[], $3::int4[], $4::float4[], $5::float8[], $6::float4[], $7::text[], $8::uuid[]) 
        ")
        .bind(&body.instrument[..])
        .bind(&body.action[..])
        .bind(&body.quantity[..])
        .bind(&body.price[..])
        .bind(&body.time[..])
        .bind(&body.commission[..])
        .bind(&body.account_display_name[..])
        .bind(user_ids)
        .fetch_all(&state.db)
        .await
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

