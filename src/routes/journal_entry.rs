use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Path};
use actix_web::{HttpResponse, Responder, get, delete};
use sqlx::{self, FromRow};
use crate::startup::AppState;
use uuid::Uuid;
use crate::utils::e500;
use crate::session_state::TypedSession;
use anyhow::Context;

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

#[derive(Debug, Deserialize, Serialize)]
pub struct JournalEntryRequest {
    pub entry_date: Option<i32>,
    pub image_urls: Option<Vec<String>>,
    pub notes: Option<String>,
}

impl std::fmt::Display for JournalEntryRequest {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(
            f,
            "JournalEntryFields: entry_date: {:?}\n, image_urls: {:?}\n, notes: {:?}",
            self.entry_date,
            self.image_urls,
            self.notes,
        )
    }
}

#[derive(Debug, Deserialize)]
pub struct GetJournalEntryRequest {
    tail: Option<String>,
}

#[tracing::instrument(
    name = "Index of journal entries without params",
    skip(state, session),
)]
#[get("")]
pub async fn index(state: Data<AppState>, session: TypedSession) -> Result<impl Responder, actix_web::Error> {
    /* fill the "" below in with today's date */
    let journal_entries = get_journal_entries(&state, "", 0, 0, 0).await.map_err(e500)?;
    Ok(HttpResponse::Ok().content_type("application/json").json(journal_entries))
}

#[tracing::instrument(
    name = "Listing journal entries with params",
    skip(state),
)]
#[get("/{tail:.*}")]
pub async fn list(state: Data<AppState>, query_params: Path<GetJournalEntryRequest>) -> impl Responder {
    let tails: Vec<&str> = query_params.tail.as_ref().expect("asdf").split('/').collect();
    set_config(&tails);
    let mut t_iter = tails.iter();
    let view = *t_iter.next().unwrap();
    /*
     * TODO
     * Replace 2023, 1, and 1 with either constants and some kind of get_current_year() function
     */
    let year = t_iter.next().unwrap_or(&"2023").parse::<i32>().unwrap();
    let month = t_iter.next().unwrap_or(&"1").parse::<u32>().unwrap();
    let day = t_iter.next().unwrap_or(&"1").parse::<u32>().unwrap();
    match get_journal_entries(&state, view, year, month, day)
        .await
        {
            Ok(trades) => HttpResponse::Ok().content_type("application/json").json(trades),
            Err(err) => HttpResponse::NotFound().json(format!("Error: {err}")),
        }
}

#[tracing::instrument(
    name = "Grabbing journal entries from the database",
    skip(state),
)]
pub async fn get_journal_entries(state: &Data<AppState>, view: &str, year: i32, month: u32, day: u32) -> Result<Vec<JournalEntry>, sqlx::Error> {
    sqlx::query_as::<_, JournalEntry>("SELECT id, entry_date, image_urls, notes, created_at, updated_at from journal_entries")
        .fetch_all(&state.db)
        .await
}

fn set_config(tail: &[&str]) {
    for val in tail.iter() {
    }
}

#[delete("/{journal_entry_id}")]
pub async fn delete(_state: Data<AppState>, _path: Path<(String,)>) -> HttpResponse {
    // TODO: Delete journal entry by ID
    // in any case return status 204

    HttpResponse::NoContent()
        .content_type("application/json")
        .await
        .unwrap()
}

pub struct GetJournalEntryError(sqlx::Error);

impl std::fmt::Display for GetJournalEntryError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "A database failure was encountered while trying to get journal entries."
        )
    }
}
