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
    let trades = sqlx::query_as::<_, AccountForIndexTable>(&query)
        .fetch_all(db)
        .await?;
    Ok(trades)
}
