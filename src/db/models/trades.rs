use anyhow::Context;
use sqlx::{self, FromRow, postgres::PgArguments, Arguments};
use actix_web::web::{Data, Form, Query};
use serde::{Deserialize, Serialize};
use secrecy::ExposeSecret;

use crate::errors::*;
use crate::startup::AppState;
use crate::routes::users::UserForm;
use crate::authentication::compute_password_hash;
use crate::telemetry::spawn_blocking_with_tracing;

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

#[derive(Deserialize, Debug)]
pub struct TradeQuery {
    pub id: Option<i64>,
    pub instrument: Option<String>,
    pub account_id: Option<i64>,
    pub entry_time: Option<f64>,
    pub exit_time: Option<f64>,
    pub short: Option<bool>,
    pub start_time: Option<f64>,
    pub end_time: Option<f64>,
}

impl TradeQuery {
    pub fn as_query(&self) -> String {
        let query = String::from("SELECT id, account_id, instrument, entry_time, exit_time, commission, pnl, short, created_at, updated_at FROM trades");
        let _vals: Vec<&str> = Vec::new();
        return query;
    }

    pub fn as_vec(&self) -> Vec<&'static str> {
        let mut vals: Vec<&'static str> = Vec::new();
        if self.id.is_some() {
            vals.push(&"id =");
        }
        if self.instrument.is_some() {
            vals.push(&"instrument =");
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
        if self.short.is_some() {
            vals.push(&"short =");
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
        match &self.instrument {
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
        match &self.short {
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

#[tracing::instrument(
    name = "Grabbing trades from the database",
    skip(state, tq),
)]
pub async fn get_trades(state: &Data<AppState>, tq: &Query<TradeQuery>) -> Result<Vec<Trade>, sqlx::Error> {
    let mut query = String::from("SELECT id, account_id, instrument, entry_time, exit_time, commission, pnl, short, created_at, updated_at from trades");
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

