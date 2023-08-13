use serde::{Deserialize, Serialize};
use actix_session::SessionGetError;
use actix_web::web::{Data, Path, Json};
use actix_web::{HttpResponse, HttpRequest, Responder, get, delete, post};
use sqlx::{self, FromRow};
use crate::startup::AppState;
use crate::utils::error_chain_fmt;
use uuid::Uuid;
use crate::utils::e500;
use crate::session_state::TypedSession;
use anyhow::Context;
use actix_web::http::StatusCode;
use actix_web::ResponseError;

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
    pub id: Option<i64>,
    pub entry_date: i32,
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
    _tail: Option<String>,
}

fn _set_config(tail: &[&str]) {
    for _val in tail.iter() {
    }
}

#[tracing::instrument(
    name = "Index of journal entries without params",
    skip(state),
)]
#[get("")]
pub async fn index(state: Data<AppState>) -> Result<impl Responder, actix_web::Error> {
    /* fill the "" below in with today's date */
    let journal_entries = get_journal_entries(&state).await.map_err(e500)?;
    Ok(HttpResponse::Ok().content_type("application/json").json(journal_entries))
}

#[tracing::instrument(
    name = "Grabbing journal entries from the database",
    skip(state),
)]
pub async fn get_journal_entries(state: &Data<AppState>) -> Result<Vec<JournalEntry>, GetJournalEntryError> {
    sqlx::query_as::<_, JournalEntry>("SELECT id, user_id, entry_date, image_urls, notes, created_at, updated_at from journal_entries")
        .fetch_all(&state.db)
        .await
        .map_err(GetJournalEntryError)
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

#[tracing::instrument(
    name = "Creating a new journal entry",
    skip(state, body, session),
    fields(
        entry_date = ?body.entry_date,
        image_urls = ?body.image_urls,
        notes = ?body.notes,
    )
)]
#[post("")]
pub async fn create(
    state: Data<AppState>,
    body: Json<JournalEntryRequest>,
    session: TypedSession,
    request: HttpRequest,
) -> Result<HttpResponse, JournalEntryError> {
    let user_id = if let Some(user_id) = session.get_user_id().map_err(JournalEntryError::SessionError)? {
        user_id
    } else {
        return Ok(HttpResponse::Unauthorized().json("you are not authorized"));
    };

    let user = insert_journal_entry(&state, &body, &user_id).await.context("Failed to commit user to the database")?;
    Ok(HttpResponse::Ok().json(user))
}

#[tracing::instrument(
    name = "Saving new journal entry in the database",
    skip(state, body),
)]
pub async fn insert_journal_entry(state: &Data<AppState>, body: &Json<JournalEntryRequest>, user_id: &Uuid) -> Result<JournalEntry, anyhow::Error> {
    let notes = body.notes.clone().unwrap_or_default();
    let image_urls = body.image_urls.clone().unwrap_or_default();
    sqlx::query_as::<_, JournalEntry>(
        "INSERT INTO journal_entries (user_id, entry_date, image_urls, notes) VALUES ($1, $2, $3, $4) RETURNING id, user_id, entry_date, image_urls, notes, created_at, updated_at"
    )
    .bind(user_id)
    .bind(body.entry_date)
    .bind(image_urls)
    .bind(notes)
    .fetch_one(&state.db)
    .await
    .context("A database failure was encountered while trying to store the journal entry")
}

pub async fn update(
    state: Data<AppState>,
    body: Json<JournalEntryRequest>,
    session: TypedSession,
    _request: HttpRequest,
) -> Result<HttpResponse, JournalEntryError> {
    let _user_id = if let Some(user_id) = session.get_user_id().map_err(JournalEntryError::SessionError)? {
        user_id
    } else {
        return Ok(HttpResponse::Unauthorized().json("you are not authorized"));
    };
    let journal_id = sqlx::query_as::<_, JournalEntry>(
        "SELECT FROM journal_entries user_id WHERE id = $1 and entry_date = $2"
        )
        .bind(body.id)
        .bind(body.entry_date)
        .fetch_one(&state.db)
        .await
        .context("Getting journal Entry error")?;
    Ok(HttpResponse::Ok().json(journal_id))
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

impl std::error::Error for GetJournalEntryError {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        Some(&self.0)
    }
}

impl std::fmt::Debug for GetJournalEntryError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

#[derive(thiserror::Error)]
pub enum JournalEntryError {
    #[error("{0}")]
    ValidationError(String),
    #[error("Authentication failed.")]
    AuthError(#[source] anyhow::Error),
    #[error(transparent)]
    UnexpectedError(#[from] anyhow::Error),
    #[error("Session get error")]
    SessionError(#[from] SessionGetError)
}

impl std::fmt::Debug for JournalEntryError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

impl ResponseError for JournalEntryError {
    fn error_response(&self) -> HttpResponse {
        match self {
            JournalEntryError::ValidationError(_) => HttpResponse::new(StatusCode::BAD_REQUEST),
            JournalEntryError::AuthError(_) => HttpResponse::new(StatusCode::UNAUTHORIZED),
            JournalEntryError::SessionError(_) => HttpResponse::new(StatusCode::UNAUTHORIZED),
            JournalEntryError::UnexpectedError(_) => HttpResponse::new(StatusCode::INTERNAL_SERVER_ERROR),
        }
    }
}

