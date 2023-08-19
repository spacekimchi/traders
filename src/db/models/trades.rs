use anyhow::Context;
use sqlx::{self, FromRow, postgres::PgArguments, Arguments};
use actix_web::web::{Data, Form, Query};
use serde::{Deserialize, Serialize};
use secrecy::ExposeSecret;

use crate::errors::*;
use crate::startup::AppState;
use crate::routes::api::users::UserForm;
use crate::authentication::compute_password_hash;
use crate::telemetry::spawn_blocking_with_tracing;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct Trade {
    pub id: i64,
    pub account_id: i64,
	pub instrument_id: i32,
    pub entry_time: f64,
    pub exit_time: f64,
	pub commissions: f32,
    pub pnl: f32,
    pub is_short: bool,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

#[derive(Deserialize, Debug)]
pub struct TradeQuery {
    pub id: Option<i64>,
    pub instrument_id: Option<i32>,
    pub account_id: Option<i64>,
    pub entry_time: Option<f64>,
    pub exit_time: Option<f64>,
    pub is_short: Option<bool>,
    pub start_time: Option<f64>,
    pub end_time: Option<f64>,
}

impl TradeQuery {
    pub fn as_query(&self) -> String {
        let query = String::from("SELECT id, account_id, instrument, entry_time, exit_time, commissions, pnl, is_short, created_at, updated_at FROM trades");
        let _vals: Vec<&str> = Vec::new();
        return query;
    }

    pub fn as_vec(&self) -> Vec<&'static str> {
        let mut vals: Vec<&'static str> = Vec::new();
        if self.id.is_some() {
            vals.push(&"id =");
        }
        if self.instrument_id.is_some() {
            vals.push(&"instrument_id =");
        }
        if self.account_id.is_some() {
            vals.push(&"account_id =");
        }
        if self.entry_time.is_some() {
            vals.push(&"entry_time =");
        }
        if self.exit_time.is_some() {
            vals.push(&"exit_time =");
        }
        if self.is_short.is_some() {
            vals.push(&"is_short =");
        }
        if self.start_time.is_some() {
            vals.push(&"entry_time >");
        }
        if self.end_time.is_some() {
            vals.push(&"entry_time <");
        }
        vals
    }

    pub fn pg_args(&self) -> PgArguments {
        let mut args = PgArguments::default();
        match &self.id {
            Some(val) => { args.add(val); }
            _ => {}
        }
        match &self.instrument_id {
            Some(val) => { args.add(val) }
            _ => {}
        }
        match &self.account_id {
            Some(val) => { args.add(val) }
            _ => {}
        }
        match &self.entry_time {
            Some(val) => { args.add(val) }
            _ => {}
        }
        match &self.exit_time {
            Some(val) => { args.add(val) }
            _ => {}
        }
        match &self.is_short {
            Some(val) => { args.add(val) }
            _ => {}
        }
        match &self.start_time {
            Some(val) => { args.add(val) }
            _ => {}
        }
        match &self.end_time {
            Some(val) => { args.add(val) }
            _ => {}
        }
        args
    }
}

/// A query for getting all the trades made by a user, selecting trade.id, trade.pnl, and instrument.name
///
/// WITH account_id AS (select id from accounts WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80')
/// SELECT trades.id, trades.pnl, (SELECT code FROM instruments WHERE instruments.id = trades.instrument_id)
/// FROM trades WHERE trades.account_id IN (SELECT id FROM account_id)
/// AND trades.entry_time > ?
/// AND trades.exit_time < ?;
///
/// A similar query but with a JOIN instead
///
///
/// SELECT
///     trade_id,
///     total_price,
///     avg_difference,
///     first_is_buy AS is_long,
///     CASE
///         WHEN first_is_buy THEN avg_difference
///         ELSE -avg_difference
///     END * instruments.price_per_point AS adjusted_avg_difference,
///     entry_time,
///     exit_time
/// FROM (
///     SELECT
///         trades.id as trade_id,
///         sum(executions.price) AS total_price,
///         -- Calculate average for each trade's executions where is_buy = true minus where is_buy = false
///         (sum(CASE WHEN executions.is_buy = true THEN executions.price ELSE 0 END) / count(CASE WHEN executions.is_buy = true THEN 1 END)) -
///         (sum(CASE WHEN executions.is_buy = false THEN executions.price ELSE 0 END) / count(CASE WHEN executions.is_buy = false THEN 1 END)) AS avg_difference,
///         bool_or(executions.fill_time = min_fill_time AND executions.is_buy = false) AS first_is_buy, -- Check if the execution with the min fill_time has is_buy = false
///         min(executions.fill_time) AS entry_time,
///         max(executions.fill_time) AS exit_time,
///         trades.instrument_id
///     FROM trades
///     JOIN accounts ON trades.account_id = accounts.id
///     JOIN executions ON trades.id = executions.trade_id
///     LEFT JOIN (
///         SELECT trade_id, min(fill_time) AS min_fill_time
///         FROM executions
///         GROUP BY trade_id
///     ) AS min_time ON executions.trade_id = min_time.trade_id
///     WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80'
///     GROUP BY trades.id, trades.instrument_id
/// ) AS subquery
/// JOIN instruments ON subquery.instrument_id = instruments.id
/// ORDER BY entry_time;
///
///

#[tracing::instrument(
    name = "Grabbing trades from the database",
    skip(state, tq),
)]
pub async fn get_trades(state: &Data<AppState>, tq: &Query<TradeQuery>) -> Result<Vec<Trade>, sqlx::Error> {
    let mut query = String::from("SELECT id, account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short, created_at, updated_at from trades");
    let query_strings = tq
        .as_vec()
        .into_iter()
        .enumerate()
        .map(|(idx, val)| {
            format!("{} ${}", val, idx + 1)
        })
        .collect::<Vec<String>>()
        .join(" AND ");
    if !query_strings.is_empty() {
        query.push_str(format!(" WHERE {}", query_strings).as_str());
    }

    sqlx::query_as_with(&query, tq.pg_args())
        .fetch_all(&state.db)
        .await
}

