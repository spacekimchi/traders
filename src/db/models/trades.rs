//! src/db/models/trades.rs
//!
//! The purpose of this file is to hold database operations relevant to the trades table

use sqlx::{self, FromRow, PgPool};
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize}; use chrono::Datelike;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct Trade {
    pub id: i32,
    pub account_id: i64,
	pub instrument_id: i32,
    pub entry_time: DateTime<Utc>,
    pub exit_time: DateTime<Utc>,
	pub commission: f32,
    pub pnl: f32,
    pub is_long: bool,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct TradeInfoByDay {
    pub trade_day: i32, // Excel serialize date
    pub number_of_trades: i64, // TODO: see if this can be changed to an i32
    pub accounts_traded: i64, // TODO: see if this can be changed to an i32
    pub total_pnl: f32,
    pub pct_winning_trades: f64,
}

impl TradeInfoByDay {
    pub fn month_from_excel_date(&self) -> u32 {
        let base_date = chrono::NaiveDate::from_ymd_opt(1900, 1, 1).unwrap();

        // Adjusting for Excel's leap year bug
        let adj = if self.trade_day >= 61 { -1 } else { 0 };
        let dt = base_date + chrono::Duration::days((self.trade_day + adj) as i64);
        dt.month()
    }

    pub fn total_pnl_as_currency(&self) -> String {
        format!("{:.2}", self.total_pnl)
    }
}

/// This query is for displaying a calendar view of the trades
/// An additional WHERE clause can easily be added to grab within a time range
///   - WHERE trades.exit_time > $0 AND trades.exit_time < $1
///
/// We use exit_time to get the pnl of trades that were CLOSED on that day.
///
/// This is an example of rows that are returned from the query
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
pub async fn get_trades_by_day_from(db: &PgPool, start_date: DateTime<Utc>) -> Result<Vec<TradeInfoByDay>, sqlx::Error> {
    let start_date_str = start_date.to_rfc3339(); // Convert to a string in ISO 8601 format
    let query = String::from(
        format!(
"SELECT
    DATE(trades.entry_time) AS trade_day,
    COUNT(trades.id) AS number_of_trades,
    COUNT(DISTINCT accounts.id) AS accounts_traded,
    SUM(trades.pnl) - SUM(trades.commission) AS total_pnl,
    CAST(
        SUM(CASE WHEN trades.pnl - trades.commission > 0.0 THEN 1.0 ELSE 0.0 END) / COUNT(trades.id) * 100
        AS DOUBLE PRECISION
    ) AS pct_winning_trades
FROM trades
JOIN accounts ON trades.account_id = accounts.id
JOIN instruments ON instruments.id = trades.instrument_id
WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80'
AND trades.exit_time >= TIMESTAMP WITH TIME ZONE '{}'
AND accounts.sim != true
GROUP BY DATE(trades.entry_time)
ORDER BY trade_day", start_date_str)
);

    let trades = sqlx::query_as::<_, TradeInfoByDay>(&query)
        .fetch_all(db)
        .await?;
    Ok(trades)
}

/// Similar to the above query, but this will return trades in a range
/// This function and #get_trades_by_day_from can be combined into a single function
pub async fn get_trades_by_day_in_range(db: &PgPool, start_date: DateTime<Utc>, end_date: DateTime<Utc>) -> Result<Vec<TradeInfoByDay>, sqlx::Error> {
    let start_date_str = start_date.to_rfc3339(); // Convert to a string in ISO 8601 format
    let end_date_str = end_date.to_rfc3339(); // Convert to a string in ISO 8601 format
    let query = String::from(
        format!(
"SELECT
    CAST(FLOOR(trades.entry_time) AS INTEGER) AS trade_day,
    COUNT(trades.id) AS number_of_trades,
    COUNT(DISTINCT accounts.id) AS accounts_traded,
    SUM(trades.pnl) - SUM(trades.commission) AS total_pnl,
    CAST(
        SUM(CASE WHEN trades.pnl - trades.commission > 0.0 THEN 1.0 ELSE 0.0 END) / COUNT(trades.id) * 100
        AS DOUBLE PRECISION
    ) AS pct_winning_trades
FROM trades
JOIN accounts ON trades.account_id = accounts.id
JOIN instruments ON instruments.id = trades.instrument_id
WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80'
AND trades.exit_time >= TIMESTAMP WITH TIME ZONE '{}'
AND trades.exit_time <= TIMESTAMP WITH TIME ZONE '{}'
AND accounts.sim != true
GROUP BY DATE(trades.entry_time)
ORDER BY trade_day", start_date_str, end_date_str)
);
    let trades = sqlx::query_as::<_, TradeInfoByDay>(&query)
        .fetch_all(db)
        .await?;
    Ok(trades)
}

/// Basic index query to grab trades within a date range
///
pub async fn get_trades_in_range(db: &PgPool, start_date: DateTime<Utc>, end_date: DateTime<Utc>) -> Result<Vec<Trade>, sqlx::Error> {
    let start_date_str = start_date.to_rfc3339(); // Convert to a string in ISO 8601 format
    let end_date_str = end_date.to_rfc3339(); // Convert to a string in ISO 8601 format
    let query = String::from(
        format!(
"SELECT *
FROM trades
JOIN accounts ON trades.account_id = accounts.id
JOIN instruments ON instruments.id = trades.instrument_id
WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80'
AND trades.exit_time >= TIMESTAMP WITH TIME ZONE '{}'
AND trades.exit_time <= TIMESTAMP WITH TIME ZONE '{}'
AND accounts.sim != true
ORDER BY trades.entry_time DESC", start_date_str, end_date_str)
);
    let trades = sqlx::query_as::<_, Trade>(&query)
        .fetch_all(db)
        .await?;
    Ok(trades)
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct TradeForTable {
    pub pnl: f32,
    pub instrument_name: String,
    pub account_name: String,
    pub is_long: bool,
    pub duration_seconds: i64,
    pub entry_time: DateTime<Utc>,
}

pub async fn get_trades_for_table_in_range(db: &PgPool, start_date: &DateTime<Utc>, end_date: &DateTime<Utc>) -> Result<Vec<TradeForTable>, sqlx::Error> {
    let start_date_str = start_date.to_rfc3339(); // Convert to a string in ISO 8601 format
    let end_date_str = end_date.to_rfc3339(); // Convert to a string in ISO 8601 format
    let query = String::from(
        format!(
"SELECT 
    trades.pnl - trades.commission AS pnl,
    instruments.code as instrument_name,
    accounts.name as account_name,
    trades.is_long as is_long,
    EXTRACT(EPOCH FROM (trades.exit_time - trades.entry_time))::BIGINT as duration_seconds,
    trades.entry_time as entry_time
FROM trades
JOIN accounts ON trades.account_id = accounts.id
JOIN instruments ON instruments.id = trades.instrument_id
WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80'
AND trades.exit_time >= TIMESTAMP WITH TIME ZONE '{}'
AND trades.exit_time <= TIMESTAMP WITH TIME ZONE '{}'
AND accounts.sim != true
ORDER BY trades.entry_time DESC", start_date_str, end_date_str)
);
    let trades = sqlx::query_as::<_, TradeForTable>(&query)
        .fetch_all(db)
        .await?;
    Ok(trades)
}
