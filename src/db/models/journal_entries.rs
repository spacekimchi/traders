use serde::{Deserialize, Serialize};
use sqlx::{self, FromRow, PgPool};
use uuid::Uuid;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct JournalEntry {
    pub id: i64,
    pub user_id: Uuid,
    //pub image_urls: Vec<String>,
    pub notes: String,
    pub entry_date: i32,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct JournalEntryParams {
    start_date: u32,
    end_date: u32,
    user_id: Uuid,
}

pub async fn get_journal_entries_by_from(db: &PgPool, start_date: u32) -> Result<Vec<JournalEntry>, sqlx::Error> {
    let query = String::from(
        format!(
"SELECT * FROM journal_entries WHERE entry_date = {}", start_date
            )
        );

    let journal_entries = sqlx::query_as::<_, JournalEntry>(&query)
        .fetch_all(db)
        .await?;

    Ok(journal_entries)
}

pub async fn get_journal_entries_in_range(db: &PgPool, journal_entry_params: JournalEntryParams) -> Result<Vec<JournalEntry>, sqlx::Error> {
    let journal_entries = sqlx::query_as::<_, JournalEntry>(
        "SELECT *
        FROM journal_entries
        WHERE journal_entries.user_id = $1
        AND journal_entry.entry_date >= $2
        AND journal_entry.entry_date <= $3
        ORDER BY journal_entries.entry_date DESC"
    )
    .bind(&journal_entry_params.user_id)
    .bind(journal_entry_params.start_date as i32)
    .bind(journal_entry_params.end_date as i32)
    .fetch_all(db)
    .await?;

    Ok(journal_entries)
}
