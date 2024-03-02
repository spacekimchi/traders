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
        let new_account_id = sqlx::query!("INSERT INTO accounts (user_id, name, visible, sim, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id", 
                                          user_id, // Assuming you generate a new UUID for each account
                                          account_name, 
                                          true, // Assuming 'visible' default
                                          false, // Assuming 'sim' default
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
pub async fn fetch_accounts_by_user_id(user_id: &Uuid, db_pool: &PgPool) -> Result<Vec<Account>, sqlx::Error> {
    let accounts = sqlx::query_as!(Account, "SELECT * FROM accounts WHERE user_id = $1", user_id)
        .fetch_all(db_pool)
        .await?;
    Ok(accounts)
}
