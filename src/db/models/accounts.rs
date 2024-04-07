use sqlx::{PgPool, FromRow};
use uuid::Uuid;
use serde::{Deserialize, Serialize};
use chrono::Utc;

#[derive(Deserialize, Serialize, FromRow)]
pub struct Account {
    pub id: i64,
    pub user_id: uuid::Uuid,
    pub name: String,
    pub visible: bool,
    pub sim: bool,
    pub is_pa: bool,
    pub is_active: bool,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

pub async fn find_or_create_account(account_name: &str, user_id: &Uuid, db_pool: &PgPool) -> Result<i64, sqlx::Error> {
    // Attempt to find the account by name
    let account_opt = sqlx::query_as::<_, Account>("SELECT * FROM accounts WHERE user_id = $1 AND name = $2")
        .bind(user_id)
        .bind(account_name)
        .fetch_optional(db_pool)
        .await?;

    if let Some(account) = account_opt {
        Ok(account.id) // Return existing account ID
    } else {
        // Account does not exist, create a new one
        let is_pa = account_name.starts_with("PA");
        let new_account_id = sqlx::query!("INSERT INTO accounts (user_id, name, visible, sim, is_pa, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id", 
                                          user_id, // Assuming you generate a new UUID for each account
                                          account_name, 
                                          true, // Assuming 'visible' default
                                          false, // Assuming 'sim' default
                                          is_pa,
                                          Utc::now(), 
                                          Utc::now()
                                         )
            .fetch_one(db_pool)
            .await?
            .id;

        Ok(new_account_id)
    }
}

/// This function is for grabbing the accounts the belong to a user.
pub async fn fetch_accounts_by_user_id(db: &PgPool, user_id: &Uuid) -> Result<Vec<Account>, sqlx::Error> {
    let accounts = sqlx::query_as!(Account, "SELECT * FROM accounts WHERE user_id = $1", user_id)
        .fetch_all(db)
        .await?;
    Ok(accounts)
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct AccountForIndexTable {
    pub id: i64,
    pub name: String,
    pub is_pa: bool,
    pub total_pnl: f32,
    pub total_trades: i64,
    pub last_trade_date: f64,
    pub win_percent: f64,
}

/// This function is for grabbing the accounts the belong to a user formatted
/// for displaying on the accounts index page
pub async fn fetch_accounts_by_user_id_for_index_table(db: &PgPool, user_id: &Uuid) -> Result<Vec<AccountForIndexTable>, sqlx::Error> {
    let query = String::from(
        format!(
"SELECT
    accounts.id as id,
    accounts.name AS name,
    accounts.is_pa AS is_pa,
    SUM(trades.pnl) - SUM(trades.commission) AS total_pnl,
    COUNT(trades.id) AS total_trades,
    MAX(trades.exit_time) AS last_trade_date,
    CAST(
        SUM(CASE WHEN trades.pnl - trades.commission > 0.0 THEN 1.0 ELSE 0.0 END) / COUNT(trades.id) * 100
        AS DOUBLE PRECISION
    ) AS win_percent
FROM accounts
JOIN trades ON trades.account_id = accounts.id AND trades.user_id = accounts.user_id
WHERE accounts.user_id = '{}'
GROUP BY accounts.id, accounts.name, accounts.is_pa
ORDER BY last_trade_date DESC", user_id)
);
    let accounts = sqlx::query_as::<_, AccountForIndexTable>(&query)
        .fetch_all(db)
        .await?;
    Ok(accounts)
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct AccountTradesByDay {
    pub trade_day: i32,
    pub total_trades_count: i64,
    pub total_pnl: f32,
    pub account_name: String,
    pub account_id: i64,
    pub is_pa: bool,
    pub winning_trades_count: i64,
}
/// Get Active PAs with total PnL by day.
///
/// This function is mainly for developing the chart
pub async fn fetch_accounts_for_pnl_charts(db: &PgPool, user_id: &Uuid) -> Result<Vec<AccountForPnlChart>, sqlx::Error> {
    let accounts_for_pnl_chart = sqlx::query_as::<_, AccountTradesByDay>(
        "SELECT
            CAST(FLOOR(trades.entry_time) AS INTEGER) AS trade_day,
            COUNT(trades.id) AS total_trades_count,
            SUM(trades.pnl) - SUM(trades.commission) AS total_pnl,
            accounts.name AS account_name,
            accounts.id as account_id,
            accounts.is_pa AS is_pa,
            COUNT(CASE WHEN trades.pnl - trades.commission > 0.0 THEN 1 END) as winning_trades_count
        FROM trades
        JOIN accounts ON trades.account_id = accounts.id
        WHERE accounts.user_id = $1
        AND accounts.is_pa = $2
        GROUP BY FLOOR(trades.entry_time), accounts.id, accounts.name, accounts.is_pa
        ORDER BY trade_day, is_pa, account_name"
    )
    .bind(user_id)
    .bind(true)
    .fetch_all(db)
    .await?;

    Ok(format_query_for_pnl_charts(&accounts_for_pnl_chart))
}

#[derive(Debug, Deserialize, Serialize, Clone)]
pub struct AccountForPnlChart {
    pub account_id: i64,
    pub account_name: String,
    pub trade_day_pnls: Vec<f32>,
    pub trade_days: Vec<i32>,
    pub total_pnl: f32,
    pub total_trades_count: i64,
    pub winning_trades_count: i64,
    pub largest_day: f32,
    pub winning_days_pnl_total: f32,
    pub losing_days_pnl_total: f32,
    pub total_winning_days: i32,
    pub total_losing_days: i32,
}

fn format_query_for_pnl_charts(trades_by_accounts: &Vec<AccountTradesByDay>) -> Vec<AccountForPnlChart> {
    let mut accounts_for_pnl_chart: std::collections::HashMap<i64, AccountForPnlChart> = std::collections::HashMap::new();
    for trades_by_account in trades_by_accounts {
        match accounts_for_pnl_chart.get_mut(&trades_by_account.account_id) {
            Some(account_for_pnl_chart) => {
                let total_pnl = trades_by_account.total_pnl;
                account_for_pnl_chart.total_pnl += total_pnl;
                account_for_pnl_chart.trade_day_pnls.push(total_pnl);
                account_for_pnl_chart.trade_days.push(trades_by_account.trade_day);
                account_for_pnl_chart.total_trades_count += 1;
                account_for_pnl_chart.winning_trades_count += trades_by_account.winning_trades_count;
                if total_pnl > 0.0 {
                    account_for_pnl_chart.total_winning_days += 1;
                    account_for_pnl_chart.winning_days_pnl_total += total_pnl;
                } else if 0.0 > total_pnl {
                    account_for_pnl_chart.total_losing_days += 1;
                    account_for_pnl_chart.losing_days_pnl_total += total_pnl;
                }
                if trades_by_account.total_pnl > account_for_pnl_chart.largest_day {
                    account_for_pnl_chart.largest_day = trades_by_account.total_pnl;
                }
            },
            None => {
                let mut winning_day_pnl_total = 0.0;
                let mut losing_day_pnl_total = 0.0;
                let total_pnl = trades_by_account.total_pnl;
                let mut winning_day = 0;
                let mut losing_day = 0;
                if trades_by_account.total_pnl > 0.0 {
                    winning_day_pnl_total = total_pnl;
                    winning_day = 1;
                };
                if 0.0 > trades_by_account.total_pnl {
                    losing_day_pnl_total = total_pnl;
                    losing_day = 1;
                };
                accounts_for_pnl_chart.insert(trades_by_account.account_id, AccountForPnlChart {
                    account_id: trades_by_account.account_id,
                    account_name: trades_by_account.account_name.clone(),
                    trade_day_pnls: vec![total_pnl],
                    trade_days: vec![trades_by_account.trade_day],
                    total_pnl,
                    total_trades_count: trades_by_account.total_trades_count,
                    winning_trades_count: trades_by_account.winning_trades_count,
                    largest_day: total_pnl,
                    winning_days_pnl_total: winning_day_pnl_total,
                    losing_days_pnl_total: losing_day_pnl_total,
                    total_winning_days: winning_day,
                    total_losing_days: losing_day,
                });
            }
        }
    }

    let accounts_for_pnl_chart: Vec<AccountForPnlChart> = accounts_for_pnl_chart.values().cloned().collect();
    accounts_for_pnl_chart
}
