use serde::{Deserialize, Serialize};
use sqlx::{self, FromRow, PgPool};
use uuid::Uuid;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct JournalEntry {
    pub id: i64,
    pub user_id: Uuid,
    pub entry_date: i32,
    pub image_urls: Vec<String>,
    pub notes: String,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
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
