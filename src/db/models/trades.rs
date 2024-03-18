//! src/db/models/trades.rs
//!
//! The purpose of this file is to hold database operations relevant to the trades table
use sqlx::{self, FromRow, PgPool};
use serde::{Deserialize, Serialize};
use chrono::Datelike;

use crate::errors::trade_errors::TradeError;
use crate::db::models::executions::PendingExecution;
use crate::db::models::trade_processing_statuses;
use crate::instrument_prices;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct Trade {
    pub id: i32,
    pub account_id: i64,
    pub ticker: String,
    pub entry_time: f64,
    pub exit_time: f64,
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
        // TODO: Fix this to not use unwrap and handle the case correctly
        let dt = base_date + chrono::Duration::try_days((self.trade_day + adj) as i64).unwrap();
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
pub async fn get_trades_by_day_from(db: &PgPool, start_date: u32) -> Result<Vec<TradeInfoByDay>, TradeError> {
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
WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80'
AND trades.exit_time >= {}
AND accounts.sim != true
GROUP BY FLOOR(trades.entry_time)
ORDER BY trade_day", start_date)
);

    let trades = sqlx::query_as::<_, TradeInfoByDay>(&query)
        .fetch_all(db)
        .await?;
    Ok(trades)
}

/// Similar to the above query, but this will return trades in a range
/// This function and #get_trades_by_day_from can be combined into a single function
pub async fn get_trades_by_day_in_range(db: &PgPool, start_date: u32, end_date: u32) -> Result<Vec<TradeInfoByDay>, TradeError> {
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
WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80'
AND trades.exit_time >= {}
AND trades.exit_time <= {}
AND accounts.sim != true
GROUP BY FLOOR(trades.entry_time)
ORDER BY trade_day", start_date, end_date)
);
    let trades = sqlx::query_as::<_, TradeInfoByDay>(&query)
        .fetch_all(db)
        .await?;
    Ok(trades)
}


#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct TradeForTable {
    pub pnl: f32,
    pub ticker: String,
    pub account_name: String,
    pub is_long: bool,
    pub duration_seconds: i64,
    pub entry_time: f64,
}

pub async fn get_trades_for_table_in_range(db: &PgPool, start_date: u32, end_date: u32) -> Result<Vec<TradeForTable>, TradeError> {
    let query = String::from(
        format!(
"SELECT 
    trades.pnl - trades.commission AS pnl,
    trades.ticker as ticker,
    accounts.name as account_name,
    trades.is_long as is_long,
    trades.exit_time - trades.entry_time as duration_seconds,
    trades.entry_time as entry_time
FROM trades
JOIN accounts ON trades.account_id = accounts.id
WHERE accounts.user_id = '6982c6df-3d03-4583-8fa9-07386cf25f80'
AND trades.exit_time >= {}
AND trades.exit_time <= {}
ORDER BY trades.entry_time DESC", start_date, end_date)
);
    let trades = sqlx::query_as::<_, TradeForTable>(&query)
        .fetch_all(db)
        .await?;
    Ok(trades)
}

struct TradeToSave {
    user_id: uuid::Uuid,
    account_id: i32,
    ticker: String,
    entry_time: f64,
    exit_time: Option<f64>,
    commission: f32,
    pnl: f32,
    is_long: bool,
    is_open: bool,
}

impl TradeToSave {
    pub fn to_string(&self) -> String {
        format!(
            "Trade: ticker: {}, is_long: {}, is_open: {}", self.ticker, self.is_long, self.is_open
            )
    }
}

/// This function is used to process a vector of Vec< PendingExecution>
/// The implementation of this is in O(n). It is a monotonic stack.
/// TODO: Needs to be refactored to be cleaner and easier to read
pub async fn process_pending_executions_into_trades(db: &PgPool, pending_executions: &mut Vec<PendingExecution>, user_id: &uuid::Uuid) -> Result<(), TradeError> {
    let mut trades: Vec<TradeToSave> = Vec::new();
    let mut execution_stack: Vec<PendingExecution> = Vec::new();
    let mut execution_ids: Vec<i64> = Vec::new();
    //let mut pending_executions_by_account: HashMap<i32, Vec<&mut PendingExecution>> = HashMap::new();
    let attempted_execution_ids = pending_executions.iter().map(|pe| pe.id).collect::<Vec<i64>>();

    let trade_processing_status_id = trade_processing_statuses::start(db, user_id, &attempted_execution_ids).await?;
    // Starting a new transaction
    let mut transaction = db.begin().await?;
    let mut should_commit_transaction = true;
    for pending_execution in pending_executions {
        let mut pnl = 0.0;
        let mut commission = 0.0;
        execution_ids.push(pending_execution.id);
        while let Some(top_of_stack) = execution_stack.last_mut() {
            // We exit the loop if the pending execution is on th same side as the current trade
            if top_of_stack.is_buy == pending_execution.is_buy {
                break;
            }
            let ticks_per_point = instrument_prices::by_symbol(top_of_stack.ticker.as_str()).0;
            let price_per_tick = instrument_prices::by_symbol(top_of_stack.ticker.as_str()).1;
            // We add to commission when the execution reaches 0 quantity
            if top_of_stack.quantity == pending_execution.quantity {
                pnl += (pending_execution.price - top_of_stack.price) * ticks_per_point * price_per_tick * top_of_stack.quantity as f32;
                // We add both commissions because we are at the end of both quantities
                commission += top_of_stack.commission + pending_execution.commission;
                pending_execution.quantity = 0;
                execution_stack.pop();
                break;
            }
            if top_of_stack.quantity < pending_execution.quantity {
                pnl += (pending_execution.price - top_of_stack.price) * ticks_per_point * price_per_tick * top_of_stack.quantity as f32;
                pending_execution.quantity -= top_of_stack.quantity;
                commission += top_of_stack.commission;
                execution_stack.pop();
            } else {
                // top_of_stack.quantity > pending_execution.quantity
                // top_of_stack should have remaining executions in the stack so we don't pop it
                pnl += (pending_execution.price - top_of_stack.price) * ticks_per_point * price_per_tick * pending_execution.quantity as f32;
                top_of_stack.quantity -= pending_execution.quantity;
                pending_execution.quantity = 0;
                commission += pending_execution.commission;
                break;
            }
        }
        let execution_ids_str = execution_ids.iter().map(ToString::to_string).collect::<Vec<String>>().join(", ");
        // Matching for the different cases.
        // Whenever something goes wrong, we want to clear all of the current trackings
        match (execution_stack.last_mut(), trades.last_mut()) {
            // This should always be the first match to happen
            // It's like the initializer
            (None, None) => {
                if pending_execution.seems_like_initial_entry() {
                    execution_stack.push(pending_execution.clone());
                    trades.push(TradeToSave {
                        user_id: pending_execution.user_id,
                        account_id: pending_execution.account_id,
                        ticker: pending_execution.ticker.clone(),
                        entry_time: pending_execution.fill_time,
                        exit_time: None,
                        is_long: pending_execution.is_long(),
                        is_open: true,
                        commission: 0.0,
                        pnl: 0.0,
                    });
                } else {
                    eprintln!("Something went wrong. Quantity and position should be same or opposites when it is the initial execution");
                    let message = format!("Failed. Should have been the start of processing.\nPendingExecution: {}\nExecution_ids: {}", pending_execution.to_string(), execution_ids_str);
                    trade_processing_statuses::record_message(db, user_id, &trade_processing_status_id, &message).await?;
                    trade_processing_statuses::end_with_error(db, user_id, &trade_processing_status_id, &execution_ids).await?;
                    clear_trade_making_vecs(&mut trades, &mut execution_stack, &mut execution_ids);
                    should_commit_transaction = false;
                    break;
                }
            },
            // This case handles should be for when we are either at the start or end of a trade
            // START OF TRADE:
            //   1. Add the trade to the execution_stack.
            //     a. We know we are at the start of a trade if the pending_execution.quantity > 0
            //   2. We don't want to edit the most recent trade
            //   3. Most recent trade should have trade.is_open == false
            //
            // END OF TRADE:
            //   1. Add pnl and commission to the most recent trade
            //   2. Close the trade
            //   3. pending_execution.position are 0 when it is the last execution in stack
            (None, Some(trade)) => {
                if pending_execution.quantity > 0 && pending_execution.seems_like_initial_entry() && !trade.is_open {
                    // START OF TRADE CASE
                    execution_stack.push(pending_execution.clone());
                    trades.push(TradeToSave {
                        user_id: pending_execution.user_id,
                        account_id: pending_execution.account_id,
                        ticker: pending_execution.ticker.clone(),
                        entry_time: pending_execution.fill_time,
                        exit_time: None,
                        is_long: pending_execution.is_long(),
                        is_open: true,
                        commission: 0.0,
                        pnl: 0.0,
                    });
                } else if pending_execution.quantity == 0 && pending_execution.position == 0 && trade.is_open && trade.is_long == pending_execution.is_long() {
                    // END OF TRADE CASE
                    trade.pnl += pnl;
                    trade.commission += commission;
                    trade.exit_time = Some(pending_execution.fill_time);
                    trade.is_open = false;

                    // If the trade is a short, we want to multiply the pnl by -1
                    if !trade.is_long {
                        trade.pnl *= -1.0;
                    }

                    // Since it is the end of a trade, we want to save them to the database
                    // We only want to add Trades to the database if they are closed.
                    // TODO: do a bulk save to trades
                    let trade_id = trade_to_save_to_database(&mut transaction, &trade).await?;
                    // We also want to update the trade_id of the executions in this trade
                    update_execution_trade_id(&mut transaction, &execution_ids, trade_id).await?;
                    // Clear the executions for the next iteration
                    execution_ids.clear();
                } else {
                    eprintln!("If we are in here, then there is something wrong.");
                    // Record an error message
                    let message = format!("Failed PendingExecution: {}\nFailed trade: {}\nExecution_ids: {}", pending_execution.to_string(), trade.to_string(), execution_ids_str);
                    trade_processing_statuses::record_message(db, user_id, &trade_processing_status_id, &message).await?;
                    trade_processing_statuses::end_with_error(db, user_id, &trade_processing_status_id, &execution_ids).await?;
                    clear_trade_making_vecs(&mut trades, &mut execution_stack, &mut execution_ids);
                    should_commit_transaction = false;
                    break;
                }
            },
            // There are pending_execution left in the stack.
            // The pending_execution is either same side as the most recent trade
            // or the pending_execution has a quantity of 0 from the monotonic stack above
            (Some(execution), Some(trade)) => {
                trade.pnl += pnl;
                trade.commission += commission;
                // If it isn't one of these two conditions, then pending_execution.quantity == 0
                // and in this case we just want to move on to the next pending_execution
                if pending_execution.is_buy == execution.is_buy && pending_execution.quantity > 0 {
                    execution_stack.push(pending_execution.clone());
                } else if pending_execution.quantity != 0 {
                    eprintln!("Something went wrong in here!");
                    let message = format!("Failed with executions in the execution_stack.\nPendingExecution: {}\nTop of stack: {}\nFailed trade: {}\nExecution_ids: {}", pending_execution.to_string(), execution.to_string(), trade.to_string(), execution_ids_str);
                    trade_processing_statuses::record_message(db, user_id, &trade_processing_status_id, &message).await?;
                    trade_processing_statuses::end_with_error(db, user_id, &trade_processing_status_id, &execution_ids).await?;
                    clear_trade_making_vecs(&mut trades, &mut execution_stack, &mut execution_ids);
                    should_commit_transaction = false;
                    break;
                }
            },
            (Some(execution), None) => {
                eprintln!("Something went wrong");
                let message = format!("Failed with executions in the execution_stack but no trade.\nPendingExecution: {}\nTop of stack: {}\nExecution_ids: {}", pending_execution.to_string(), execution.to_string(), execution_ids_str);
                trade_processing_statuses::record_message(db, user_id, &trade_processing_status_id, &message).await?;
                trade_processing_statuses::end_with_error(db, user_id, &trade_processing_status_id, &execution_ids).await?;
                clear_trade_making_vecs(&mut trades, &mut execution_stack, &mut execution_ids);
                should_commit_transaction = false;
                break;
            }
        }
    }
    if should_commit_transaction {
        transaction.commit().await?;
        // We will record the success of creating trades
        // db: &PgPool, user_id: &uuid::Uuid, trade_processing_status_id: &TradeProcessingStatusId, message: &String
        let message = format!("Executions were successfully processed into trades and saved in the database.");
        trade_processing_statuses::record_message(db, user_id, &trade_processing_status_id, &message).await?;
        trade_processing_statuses::end_with_success(db, user_id, &trade_processing_status_id).await?;
    }
    Ok(())
}

// Define a struct to represent the result of the query
#[derive(sqlx::FromRow)]
struct TradeId {
    id: i64,
}

async fn trade_to_save_to_database(transaction: &mut sqlx::Transaction<'_, sqlx::Postgres>, trade: &TradeToSave) -> Result<i64, sqlx::error::Error> {
    let trade_id = sqlx::query_as!(
        TradeId,
        "INSERT INTO trades (user_id, account_id, ticker, entry_time, exit_time, is_long, is_open, commission, pnl) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING id",
        trade.user_id,
        trade.account_id as i64,
        trade.ticker,
        trade.entry_time,
        trade.exit_time,
        trade.is_long,
        trade.is_open,
        trade.commission,
        trade.pnl
        )
        .fetch_one(transaction)
        .await?
        .id;

    Ok(trade_id)
}

async fn update_execution_trade_id(transaction: &mut sqlx::Transaction<'_, sqlx::Postgres>, execution_ids: &Vec<i64>, trade_id: i64) -> Result<(), sqlx::error::Error> {
    sqlx::query!(
        "UPDATE executions SET trade_id = $1 WHERE id = ANY($2)",
        trade_id,
        execution_ids
    )
    .execute(transaction)
    .await?;

    Ok(())
}

fn clear_trade_making_vecs(trades: &mut Vec<TradeToSave>, execution_stack: &mut Vec<PendingExecution>, execution_ids: &mut Vec<i64>) {
    trades.clear();
    execution_stack.clear();
    execution_ids.clear();
}
