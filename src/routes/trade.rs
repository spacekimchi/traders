use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Path};
use actix_web::{HttpResponse, Responder, get, delete};
use sqlx::{self, FromRow};
use crate::startup::AppState;
use uuid::Uuid;
use crate::utils::e500;
use crate::session_state::TypedSession;
use anyhow::Context;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct Trade {
    pub id: i64,
    pub account_id: i64,
	pub instrument: String,
    pub entry_time: f64,
    pub exit_time: f64,
	pub commission: f32,
    pub pnl: f32,
    pub short: bool,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TradeRequest {
    pub instrument: Vec<String>,
	pub entry_time: Vec<f64>,
	pub exit_time: Vec<f64>,
	pub commission: Vec<f32>,
	pub pnl: Vec<f32>,
	pub short: Vec<bool>,
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

#[derive(Debug, Deserialize)]
pub struct GetTradesRequest {
    tail: Option<String>,
}

#[tracing::instrument(
    name = "Index of trades without params",
    skip(state, session),
)]
#[get("")]
pub async fn index(state: Data<AppState>, session: TypedSession) -> Result<impl Responder, actix_web::Error> {
    /* fill the "" below in with today's date */
    let username = if let Some(user_id) = session
        .get_user_id()
        .map_err(e500)?
        {
            get_username(user_id, &state).await.map_err(e500)?
        } else {
            return Ok(HttpResponse::Unauthorized().json("you are not authorized"));
        };

    let trades = get_trades(&state, "", 0, 0, 0).await.map_err(e500)?;
    Ok(HttpResponse::Ok().content_type("application/json").json(trades))
}

#[tracing::instrument(
    name = "Listing trades with params",
    skip(state),
)]
#[get("/{tail:.*}")]
pub async fn list(state: Data<AppState>, query_params: Path<GetTradesRequest>) -> impl Responder {
    let tails: Vec<&str> = query_params.tail.as_ref().expect("asdf").split('/').collect();
    set_config(&tails);
    let mut t_iter = tails.iter();
    let view = *t_iter.next().unwrap();
    /*
     * TODO
     * Replace 2023, 1, and 1 with either constants and some kind of get_current_year() function
     */
    let year = t_iter.next().unwrap_or(&"2023").parse::<i32>().unwrap();
    let month = t_iter.next().unwrap_or(&"1").parse::<u32>().unwrap();
    let day = t_iter.next().unwrap_or(&"1").parse::<u32>().unwrap();
    match get_trades(&state, view, year, month, day)
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
pub async fn get_trades(state: &Data<AppState>, view: &str, year: i32, month: u32, day: u32) -> Result<Vec<Trade>, sqlx::Error> {
    sqlx::query_as::<_, Trade>("SELECT id, account_id, instrument, entry_time, exit_time, commission, pnl, short, created_at, updated_at from trades")
        .fetch_all(&state.db)
        .await
}

fn set_config(tail: &[&str]) {
    for val in tail.iter() {
    }
}

#[delete("/{trade_id}")]
pub async fn delete(_state: Data<AppState>, _path: Path<(String,)>) -> HttpResponse {
    // TODO: Delete trade by ID
    // in any case return status 204

    HttpResponse::NoContent()
        .content_type("application/json")
        .await
        .unwrap()
}

pub struct GetTradesError(sqlx::Error);

impl std::fmt::Display for GetTradesError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "A database failure was encountered while trying to get trades."
        )
    }
}

#[tracing::instrument(name = "Get username", skip(state))]
pub async fn get_username(
    user_id: Uuid, 
    state: &Data<AppState>,
) -> Result<String, anyhow::Error> {
    let row = sqlx::query!(
        r#"
        SELECT username
        FROM users
        WHERE id = $1
        "#,
        user_id,
    )
    .fetch_one(&state.db)
    .await
    .context("Failed to perform a query to retrieve a username.")?;
    Ok(row.username)
}
