use sqlx::{self, FromRow};
use actix_web::web::Data;
use serde::{Deserialize, Serialize}; use chrono::Datelike;

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
    pub trade_day: f64, // Excel serialize date
    pub number_of_trades: i64,
    pub accounts_traded: i64,
    pub total_pnl: f32,
    pub pct_winning_trades: f64,
}

impl TradeInfoByDay {
    pub fn month_from_excel_date(&self) -> u32 {
        let base_date = chrono::NaiveDate::from_ymd_opt(1900, 1, 1).unwrap();

        // Adjusting for Excel's leap year bug
        let adj = if self.trade_day >= 61.0 { -1.0 } else { 0.0 };
        let dt = base_date + chrono::Duration::days((self.trade_day + adj) as i64);
        dt.month()
    }
}

pub async fn get_trades_by_day_from(state: &Data<AppState>, start_date: i32) -> Result<Vec<TradeInfoByDay>, sqlx::Error> {
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
AND trades.entry_time >= {}
AND accounts.sim != true
GROUP BY FLOOR(trades.entry_time)
ORDER BY trade_day", start_date)
);
    let trades = sqlx::query_as::<_, TradeInfoByDay>(&query)
        .fetch_all(&state.db)
        .await?;
    Ok(trades)
}

