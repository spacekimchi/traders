use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Json, Path, Query};
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

/* Converts excel date format to human readable */
fn to_date(xcell: &str) {
    let daytime: Vec<&str> = xcell.split('.').collect();
    let start = chrono::NaiveDate::from_ymd_opt(1900, 1, 1).expect("DATE");
    let date = start.checked_add_signed(chrono::Duration::days(daytime[0].parse::<i64>().unwrap()));
    //println!("{}", date.unwrap());
}

fn to_xcell(year: i32, month: u32, day: u32) {
    println!("year: {}, month: {}, day: {}", year, month, day);
    let start = chrono::NaiveDate::from_ymd_opt(1900, 1, 1).expect("DATE");
    let today = chrono::NaiveDate::from_ymd_opt(year, month, day).expect("TODAY DATE");
    let dur = chrono::NaiveDate::signed_duration_since(start, today);
    println!("{}", dur);
}

#[derive(Debug, Deserialize)]
pub struct GetTradesRequest {
    view: Option<String>,
    tail: Option<String>,
    year: Option<i32>,
    month: Option<u32>,
    day: Option<u32>,
}

#[tracing::instrument(
    name = "Index of trades without params",
    skip(state),
)]
#[get("/trades")]
pub async fn index(state: Data<AppState>) -> impl Responder {
    /* fill the "" below in with today's date */
    match get_trades(&state, "", 0, 0, 0)
        .await
        {
            Ok(trades) => HttpResponse::Ok().content_type("application/json").json(trades),
            Err(err) => HttpResponse::NotFound().json(format!("Error: {err}")),
        }
}

#[tracing::instrument(
    name = "Listing trades with params",
    skip(state),
)]
#[get("/trades/{tail:.*}")]
pub async fn list(state: Data<AppState>, query_params: Path<GetTradesRequest>) -> impl Responder {
    println!("{:?}", query_params);
    let tails: Vec<&str> = query_params.tail.as_ref().expect("asdf").split('/').collect();
    //let view = tail.first();
    let mut t_iter = tails.iter();
    let view = *t_iter.next().unwrap();
    /*
     * TODO
     * Replace 2023, 1, and 1 with either constants and some kind of get_current_year() function
     */
    let year = t_iter.next().unwrap_or(&"2023").parse::<i32>().unwrap();
    let month = t_iter.next().unwrap_or(&"1").parse::<u32>().unwrap();
    let day = t_iter.next().unwrap_or(&"1").parse::<u32>().unwrap();
    println!("year: {}, month: {}, day: {}", year, month, day);
    match get_trades(&state, view, year, month, day)
        .await
        {
            Ok(trades) => {
                for trade in &trades {
                    //to_date(&trade.time.to_string());
                    println!("");
                    println!("");
                    println!("");
                    to_xcell(year, month, day);
                    println!("");
                    println!("");
                    println!("");
                }
                return HttpResponse::Ok().content_type("application/json").json(trades)
            }, Err(err) => HttpResponse::NotFound().json(format!("Error: {err}")),
        }
}

#[tracing::instrument(
    name = "Grabbing trades from the database",
    skip(state),
)]
pub async fn get_trades(state: &Data<AppState>, view: &str, year: i32, month: u32, day: u32) -> Result<Vec<Trade>, sqlx::Error> {
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

#[delete("/trades/{trade_id}")]
pub async fn delete(_state: Data<AppState>, _path: Path<(String,)>) -> HttpResponse {
    // TODO: Delete trade by ID
    // in any case return status 204

    HttpResponse::NoContent()
        .content_type("application/json")
        .await
        .unwrap()
}

