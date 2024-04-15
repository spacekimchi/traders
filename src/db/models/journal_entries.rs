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

#[derive(Debug, Deserialize, Serialize)]
pub struct JournalEntryForm {
    pub entry_date: i32,
    pub notes: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct JournalEntrySearchParams {
    start_date: u32,
    end_date: u32,
    user_id: Uuid,
}

impl JournalEntrySearchParams {
    pub fn default() -> JournalEntrySearchParams {
        JournalEntrySearchParams {
            user_id: uuid::uuid!("6982c6df-3d03-4583-8fa9-07386cf25f80"),
            start_date: 0,
            end_date: 0
        }
    }

    pub fn start_date(mut self, start_date: u32) -> Self {
        self.start_date = start_date;
        self
    }

    pub fn end_date(mut self, end_date: u32) -> Self {
        self.end_date = end_date;
        self
    }

    pub fn user_id(mut self, user_id: uuid::Uuid) -> Self {
        self.user_id = user_id;
        self
    }
}

#[derive(Debug, Deserialize, Serialize)]
pub struct JournalEntryInsertParams {
    pub user_id: Uuid,
    pub notes: String,
    pub entry_date: i32,
}

pub async fn save_journal_entry_to_database(db: &PgPool, journal_entry_insert_params: &JournalEntryInsertParams) -> Result<JournalEntry, sqlx::Error> {
    let journal_entry = sqlx::query_as::<_, JournalEntry>(
        "INSERT INTO journal_entries
        (user_id, notes, entry_date)
        VALUES ($1, $2, $3)
        RETURNING *"
    )
        .bind(&journal_entry_insert_params.user_id)
        .bind(journal_entry_insert_params.notes.clone())
        .bind(journal_entry_insert_params.entry_date)
        .fetch_one(db)
        .await?;

    Ok(journal_entry)
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

pub async fn get_journal_entries_in_range(db: &PgPool, journal_entry_params: &JournalEntrySearchParams) -> Result<Vec<JournalEntry>, sqlx::Error> {
    let journal_entries = sqlx::query_as::<_, JournalEntry>(
        "SELECT *
        FROM journal_entries
        WHERE journal_entries.user_id = $1
        AND journal_entries.entry_date >= $2
        AND journal_entries.entry_date <= $3
        ORDER BY journal_entries.entry_date DESC"
    )
        .bind(&journal_entry_params.user_id)
        .bind(journal_entry_params.start_date as i32)
        .bind(journal_entry_params.end_date as i32)
        .fetch_all(db)
        .await?;

    Ok(journal_entries)
}

