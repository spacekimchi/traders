//! src/db/models/executions.rs
//!
//! This file is for things related to executions

use std::collections::{HashMap, HashSet};

use sqlx::{self, FromRow, PgPool};
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

use crate::routes::api::execution_routes;
use crate::db::models;
use crate::errors::execution_errors::ExecutionError;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct Execution {
    pub id: i64,
    pub user_id: uuid::Uuid,
    pub account_id: i32,
    pub trade_id: Option<i64>,
    pub ticker: String,
    pub order_id: String,
    pub fill_time: f64,
    pub commission: f32,
    pub price: f32,
    pub quantity: i32,
    pub is_entry: bool,
    pub is_buy: bool,
    pub execution_id: String,
    pub position: i32,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct PendingExecution {
    pub id: i64,
    pub account_id: i32,
    pub user_id: uuid::Uuid,
    pub ticker: String,
    pub order_id: String,
    pub fill_time: f64,
    pub commission: f32,
    pub price: f32,
    pub quantity: i32,
    pub is_entry: bool,
    pub is_buy: bool,
    pub execution_id: String,
    pub position: i32,
}

impl Clone for PendingExecution {
    fn clone(&self) -> PendingExecution {
        PendingExecution {
            id: self.id,
            account_id: self.account_id,
            user_id: self.user_id,
            ticker: self.ticker.clone(),
            order_id: self.order_id.clone(),
            fill_time: self.fill_time,
            commission: self.commission,
            price: self.price,
            quantity: self.quantity,
            is_entry: self.is_entry,
            is_buy: self.is_buy,
            execution_id: self.execution_id.clone(),
            position: self.position
        }
    }
}

impl PendingExecution {
    // (pending_execution.quantity * long_multiplier) == pending_execution.position
    // this is supposed to mean that the initial trade should have a position that is
    // the same if it is long or * -1 if it is a short trade
    pub fn seems_like_initial_entry(&self) -> bool {
        let long_multiplier = match self.is_long() {
            true => 1,
            false => -1,
        };
        (self.quantity * long_multiplier) == self.position
    }

    pub fn is_long(&self) -> bool {
        self.is_entry == self.is_buy
    }

    pub fn to_string(&self) -> String {
        format!("Pending Execution: id: {}, account_id: {}, ticker: {}, quantity: {}, is_entry: {}, is_buy: {}, position: {}",
                self.id,
                self.account_id,
                self.ticker,
                self.quantity,
                self.is_entry,
                self.is_buy,
                self.position)
    }
}

#[derive(Debug)]
struct ExecutionParams {
    user_id: uuid::Uuid,
    account_id: i64,
    ticker: String,
    order_id: String,
    fill_time: f64,
    commission: f32,
    price: f32,
    quantity: i64,
    is_entry: bool,
    is_buy: bool,
    execution_id: String,
    position: i32,
}

// This should be the same length as the ExecutionParams struct
const EXECUTION_PARAMS_FIELD_COUNT: usize = 12;

/// This function is used to fetch Executions from the database
pub async fn fetch_executions_by_user_id(db_pool: &PgPool, user_id: &uuid::Uuid) -> Result<Vec<Execution>, ExecutionError> {
    let executions = sqlx::query_as!(Execution, "SELECT * FROM executions WHERE user_id = $1", user_id)
        .fetch_all(db_pool)
        .await?;
    Ok(executions)
}

/// This is to save the executions into the database.
/// This function is used in the ninja_trader_import endpoint
pub async fn save_executions_from_ninja_trader_to_database(db_pool: &PgPool, user_id: &uuid::Uuid, executions: &Vec<execution_routes::ExecutionJsonData>) -> Result<(), ExecutionError> {
    // We need these HashMaps because in the ExecutionJsonData, account_name and instruments come
    // back as strings. We need the ids to store in the executions table
    let user_accounts_ids_by_name: HashMap<String, i64> = models::accounts::fetch_accounts_by_user_id(&user_id, &db_pool)
        .await?
        .into_iter()
        .map(|account| (account.name, account.id))
        .collect();
    let all_user_accounts_ids_by_name = create_missing_accounts_from_executions(&user_id, executions, &user_accounts_ids_by_name, db_pool).await?;
    bulk_save_ninja_trader_executions(&db_pool, &user_id, &all_user_accounts_ids_by_name, &executions).await?;
    Ok(())
}

/// This function is for bulk saving ninja_trader_executions into the database
async fn bulk_save_ninja_trader_executions(db_pool: &PgPool,
                                           user_id: &uuid::Uuid,
                                           accounts: &HashMap<String, i64>,
                                           executions: &Vec<execution_routes::ExecutionJsonData>) -> Result<(), ExecutionError> {
    let mut query = "INSERT INTO executions (user_id, account_id, ticker, order_id, fill_time, commission, price, quantity, is_entry, is_buy, execution_id, position) VALUES ".to_string();
    let mut params: Vec<ExecutionParams> = Vec::new();

    // We need to go through each execution and create the fields that will be saved
    for execution in executions {
        let account_id = *accounts.get(&execution.account_name).ok_or(sqlx::Error::RowNotFound)?;
        // Update min and max fill_time

        params.push(ExecutionParams {
            user_id: *user_id,
            account_id,
            ticker: execution.ticker.clone(),
            order_id: execution.order_id.clone(),
            fill_time: execution.fill_time,
            commission: execution.commission,
            price: execution.price,
            quantity: execution.quantity,
            is_entry: execution.is_entry,
            is_buy: execution.is_buy,
            execution_id: execution.execution_id.clone(),
            position: execution.position,
        });
    }

    // We need to create a string to bulk create the executions
    for (i, _) in params.iter().enumerate() {
        let placeholders: Vec<String> = (1..=EXECUTION_PARAMS_FIELD_COUNT)
            .map(|n| format!("${}", i * EXECUTION_PARAMS_FIELD_COUNT + n))
            .collect();
        let placeholder_str = placeholders.join(", ");
        query.push_str(&format!("({}),", placeholder_str));
    }
    // We need to remove the last comma
    query.pop();
    // We dont want to save duplicate executions
    query.push_str(" ON CONFLICT (execution_id) DO NOTHING");

    // We build the query by inserting each execution into the query_string we created above
    let mut build_query = sqlx::query(&query);
    for param in params {
        build_query = build_query
            .bind(param.user_id)
            .bind(param.account_id)
            .bind(param.ticker)
            .bind(param.order_id)
            .bind(param.fill_time)
            .bind(param.commission)
            .bind(param.price)
            .bind(param.quantity)
            .bind(param.is_entry)
            .bind(param.is_buy)
            .bind(param.execution_id)
            .bind(param.position);
    }
    build_query.execute(db_pool).await?;

    Ok(())
}

/// This function is used to create new accounts from the executions passed from NinjaTrader which
/// are currently missing in the user's list of accounts in the database
async fn create_missing_accounts_from_executions(user_id: &uuid::Uuid,
                                               executions: &Vec<execution_routes::ExecutionJsonData>,
                                               current_accounts: &HashMap<String, i64>,
                                               db_pool: &PgPool) -> Result<HashMap<String, i64>, sqlx::Error> {
    let mut new_accounts = HashSet::new();
    let mut accounts = current_accounts.clone();
    for execution in executions {
        if !current_accounts.contains_key(&execution.account_name) {
            new_accounts.insert(&execution.account_name);
        }
    }

    // Insert new accounts if there are any
    for account_name in new_accounts {
        let account_id: i64 = sqlx::query!(
            "INSERT INTO accounts (user_id, name, visible, sim) VALUES ($1, $2, TRUE, FALSE) RETURNING id",
            user_id,
            account_name
            )
            .fetch_one(db_pool)
            .await?
            .id;
        accounts.insert(account_name.to_string(), account_id);
    }
    Ok(accounts)
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct ExecutionForTable {
    pub ticker: String,
    pub account_name: String,
    pub is_entry: bool,
    pub commission: f32,
    pub quantity: i32,
    pub price: f32,
    pub is_buy: bool,
    pub position: i32,
    pub trade_id: Option<i64>,
    pub fill_time: f64,
    pub created_at: DateTime<Utc>,
}

/// This function is used to grab executions that will be used grab executions in a proper format
/// to be displayed on the executions index page
pub async fn get_executions_for_index_table(db: &PgPool, user_id: &uuid::Uuid, start_date: u32, end_date: u32) -> Result<Vec<ExecutionForTable>, ExecutionError> {
    let query = String::from(
        format!(
"SELECT 
    executions.price AS price,
    executions.ticker as ticker,
    accounts.name as account_name,
    executions.is_buy as is_buy,
    executions.is_entry as is_entry,
    executions.commission as commission,
    executions.quantity as quantity,
    executions.position as position,
    executions.trade_id as trade_id,
    executions.fill_time as fill_time,
    executions.created_at as created_at
FROM executions
JOIN accounts ON executions.account_id = accounts.id
WHERE accounts.user_id = '{}'
AND executions.fill_time >= {}
AND executions.fill_time <= {}
ORDER BY executions.fill_time DESC", user_id, start_date, end_date)
);
    let executions = sqlx::query_as::<_, ExecutionForTable>(&query)
        .fetch_all(db)
        .await?;
    Ok(executions)
}

/// This function is for grabbing all of the unprocessed trades of a user
/// The ORDER BY in the query will make it easy to group trades by account, instrument, and
/// fill_time.
pub async fn get_unprocessed_executions_for_user(db: &PgPool, user_id: &uuid::Uuid) -> Result<Vec<PendingExecution>, ExecutionError> {
    let query = String::from(
        format!(
"SELECT id, account_id, user_id, ticker, order_id, fill_time, commission, price, quantity, is_entry, is_buy, execution_id, position
FROM executions
WHERE user_id = '{}'
AND trade_id IS NULL
ORDER BY account_id, ticker, fill_time, id", user_id
));
    let pending_executions = sqlx::query_as::<_, PendingExecution>(&query)
        .fetch_all(db)
        .await?;

    Ok(pending_executions)
}

