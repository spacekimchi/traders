//! src/db/models/executions.rs
//!
//! This file is for things related to executions

use std::collections::{HashMap, HashSet};

use sqlx::{self, FromRow, PgPool};
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

use crate::routes::api::executions;
use crate::excel_helpers;
use crate::db::models;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct Execution {
    pub account_id: i64,
    pub user_id: uuid::Uuid,
    pub instrument_id: i32,
    pub order_id: String,
    pub fill_time: DateTime<Utc>,
    pub commission: f32,
    pub price: f32,
    pub quantity: i64,
    pub is_entry: bool,
    pub is_exit: bool,
    pub is_buy: bool,
    pub execution_id: String,
    pub position: i32,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

/// This is to save the executions into the database.
/// This function is used in the ninja_trader_import endpoint
pub async fn save_executions_from_ninja_trader_to_database(db_pool: &PgPool, user_id: uuid::Uuid, executions: &Vec<executions::ExecutionJsonData>) -> Result<(), sqlx::Error> {
    // We need these HashMaps because in the ExecutionJsonData, account_name and instruments come
    // back as strings. We need the ids to store in the executions table
    let user_accounts_ids_by_name: HashMap<String, i64> = models::accounts::fetch_accounts_by_user_id(&user_id, &db_pool)
        .await?
        .into_iter()
        .map(|account| (account.name, account.id))
        .collect();
    println!("XXXXXXXXXXX user_accounts_ids_by_name: {:?}", user_accounts_ids_by_name);
    let instruments: HashMap<String, i32> = models::instruments::fetch_instruments(&db_pool)
        .await?
        .into_iter()
        .map(|instrument| (instrument.code, instrument.id))
        .collect();
    println!("XXXXXXXXXXX INSTRUMENTS: {:?}", instruments);
    let all_user_accounts_ids_by_name = create_missing_accounts_in_executions(&user_id, executions, &user_accounts_ids_by_name, db_pool).await?;
    println!("XXXXXXXXXXX all_user_accounts_ids_by_name: {:?}", all_user_accounts_ids_by_name);
    println!("XXXXXXXXXXX SAVING ALL NINJATRADER EXECUTIONS NOW");
    bulk_save_ninja_trader_executions(&db_pool, &user_id, &instruments, &all_user_accounts_ids_by_name, &executions).await?;
    Ok(())
}

async fn bulk_save_ninja_trader_executions(db_pool: &PgPool,
                                           user_id: &uuid::Uuid,
                                           instruments: &HashMap<String, i32>,
                                           accounts: &HashMap<String, i64>,
                                           executions: &Vec<executions::ExecutionJsonData>) -> Result<(), sqlx::Error> {
    let mut query = "INSERT INTO executions (user_id, account_id, instrument_id, order_id, fill_time, commission, price, quantity, is_entry, is_exit, is_buy, execution_id, position) VALUES ".to_string();

    let mut params: Vec<(uuid::Uuid, i64, i32, String, chrono::DateTime<chrono::Utc>, f32, f32, i64, bool, bool, bool, String, i32)> = Vec::new();

    for execution in executions {
        let account_id = *accounts.get(&execution.account_name).ok_or(sqlx::Error::RowNotFound)?;
        let instrument_id = *instruments.get(&execution.instrument_name).ok_or(sqlx::Error::RowNotFound)?;
        let fill_time = excel_helpers::excel_to_utc(execution.fill_time);
        params.push((*user_id,
                     account_id,
                     instrument_id,
                     execution.order_id.clone(),
                     fill_time,
                     execution.commission,
                     execution.price,
                     execution.quantity,
                     execution.is_entry,
                     execution.is_exit,
                     execution.is_buy,
                     execution.execution_id.clone(),
                     execution.position));

    }
    for (i, _) in params.iter().enumerate() {
        query.push_str(&format!("(${}, ${}, ${}, ${}, ${}, ${}, ${}, ${}, ${}, ${}, ${}, ${}, ${}),",
        i * 13 + 1,
        i * 13 + 2,
        i * 13 + 3,
        i * 13 + 4,
        i * 13 + 5,
        i * 13 + 6,
        i * 13 + 7,
        i * 13 + 8,
        i * 13 + 9,
        i * 13 + 10,
        i * 13 + 11,
        i * 13 + 12,
        i * 13 + 13));
    }
    query.pop(); // Remove the last comma
    query.push_str(" ON CONFLICT (execution_id) DO NOTHING");

    let mut build_query = sqlx::query(&query);
    for param in params.into_iter() {
        build_query = build_query
            .bind(param.0)
            .bind(param.1)
            .bind(param.2)
            .bind(param.3)
            .bind(param.4)
            .bind(param.5)
            .bind(param.6)
            .bind(param.7)
            .bind(param.8)
            .bind(param.9)
            .bind(param.10)
            .bind(param.11)
            .bind(param.12);
    }
    build_query.execute(db_pool).await?;

    Ok(())
}

/// This function is used to create new accounts from the executions passed from NinjaTrader which
/// are currently missing in the user's list of accounts in the database
async fn create_missing_accounts_in_executions(user_id: &uuid::Uuid,
                                               executions: &Vec<executions::ExecutionJsonData>,
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
        let account_id: i64 = sqlx::query!("INSERT INTO accounts (user_id, name, visible, sim) VALUES ($1, $2, TRUE, FALSE) RETURNING id", user_id, account_name)
            .fetch_one(db_pool)
            .await?
            .id;
        accounts.insert(account_name.to_string(), account_id);
    }
    Ok(accounts)
}

