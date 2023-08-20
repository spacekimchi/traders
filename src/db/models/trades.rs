use sqlx::{self, FromRow, postgres::PgArguments, Arguments};
use actix_web::web::{Data, Query};
use serde::{Deserialize, Serialize};

use crate::excel_helpers;
use crate::startup::AppState;

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

///
/// This query is good for displaying a calendar view of the trades
/// An additional WHERE clause can easily be added to grab within a time range
///   - WHERE trades.entry_time > $0 AND trades.exit_time < $1
///
/// SELECT
///     FLOOR(trades.entry_time) AS trade_day,
///     COUNT(trades.id) AS number_of_trades,
///     COUNT(DISTINCT accounts.id) AS accounts_traded,
///     SUM(trades.pnl) - SUM(trades.commissions) AS total_pnl,
///     SUM(CASE WHEN trades.pnl - trades.commissions > 0 THEN 1 ELSE 0 END) / COUNT(trades.id) * 100 AS pct_winning_trades
/// FROM trades
/// JOIN accounts ON trades.account_id = accounts.id
/// JOIN instruments ON instruments.id = trades.instrument_id
/// WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80'
/// AND accounts.sim != true
/// GROUP BY FLOOR(trades.entry_time)
/// ORDER BY trade_day;
///
///
/// trade_day | number_of_trades | accounts_traded | total_pnl | pct_winning_trades
///-----------+------------------+-----------------+-----------+-------------------------
///     44973 |               10 |               2 |     98.00 |                   40.00
///     44978 |                3 |               1 |    125.26 |                  100.00
///     44984 |               10 |               1 |    -53.30 |                   70.00
///     44985 |                4 |               1 |   -153.82 |                   25.00
///     44999 |                8 |               2 |     13.54 |                   75.00
///     45000 |                2 |               2 |     90.52 |                  100.00
///     45001 |                3 |               3 |     16.51 |                  100.00
///     45002 |                9 |               3 |  -1152.27 |                   66.67
///     45005 |               18 |               3 |    146.88 |                  100.00
///     45006 |               15 |               3 |     15.45 |                   60.00
///     45007 |               33 |               3 |   -282.80 |                   42.42
///     45008 |               28 |               3 |    200.91 |                   82.14
///     45009 |               11 |               3 |    105.66 |                  100.00
///     45012 |               25 |               3 |   -243.64 |                   64.00
///     45013 |               32 |               3 |      2.82 |                   96.88
///     45014 |               10 |               3 |    121.67 |                   70.00
///

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct TradeInfoByDay {
    trade_day: f64,
    number_of_trades: i64,
    accounts_traded: i64,
    total_pnl: f32,
    pct_winning_trades: f64,
}

pub async fn get_trades_by_day_in_year(state: &Data<AppState>, year: i32) -> Result<Vec<TradeInfoByDay>, sqlx::Error> {
    let first_of_year = excel_helpers::year_to_excel(year);
    let end_of_year = first_of_year + 365 + (if excel_helpers::is_leap_year(year) { 1 } else { 0 });
    let query = String::from(
format!(
"SELECT
    FLOOR(trades.entry_time) AS trade_day,
    COUNT(trades.id) AS number_of_trades,
    COUNT(DISTINCT accounts.id) AS accounts_traded,
    SUM(trades.pnl) - SUM(trades.commissions) AS total_pnl,
    CAST(
        SUM(CASE WHEN trades.pnl - trades.commissions > 0.0 THEN 1.0 ELSE 0.0 END) / COUNT(trades.id) * 100
        AS double precision
    ) AS pct_winning_trades
FROM trades
JOIN accounts ON trades.account_id = accounts.id
JOIN instruments ON instruments.id = trades.instrument_id
WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80'
AND trades.entry_time > {}
AND trades.exit_time < {}
AND accounts.sim != true
GROUP BY FLOOR(trades.entry_time)
ORDER BY trade_day", first_of_year, end_of_year)
        );
    sqlx::query_as::<_, TradeInfoByDay>(&query)
        .fetch_all(&state.db)
        .await
}

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

