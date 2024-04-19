//! src/routes/journal_entry_routes.rs
//!
//! This file is for all the routes contained under the traders.jinz.co/journal_entries url.

use actix_web::web;
use actix_web::http::header::LOCATION;

use actix_web::{web::{Data, Form}, HttpResponse, HttpRequest, get, post, put};
use serde::{Serialize, Deserialize};
use chrono::{Datelike, NaiveDate, Local};
use actix_web_flash_messages::{FlashMessage, IncomingFlashMessages};

use crate::session_state::TypedSession;
use crate::startup::AppState;
use crate::db::models::trades;
use crate::db::models::journal_entries;
use crate::excel_helpers;
use crate::utils;
use crate::template_helpers::{RenderTemplateParams, err_500_template, render_content};

/// The start_date and end_date formats should be "YEAR-MONTH-DAY" (2023-12-31)
#[derive(Debug, Serialize, Deserialize)]
pub struct JournalEntryIndexQueryStrings {
    pub start_date: Option<String>,
    pub end_date: Option<String>,
}

#[get("")]
pub async fn get_journal_entries_index(
    state: web::Data<AppState>,
    session: TypedSession,
    tera_engine: web::Data<tera::Tera>,
    query: web::Query<JournalEntryIndexQueryStrings>,
    flash_messages: IncomingFlashMessages
) -> Result<HttpResponse, actix_web::Error> 
{
    let _user_id = match session
        .get_user_id()
        .map_err(utils::e500)? {
            Some(user_id) => user_id,
            // This is supposed to reject the user if they are not authorized
            // None => return Ok(HttpResponse::Unauthorized().body("You are unauthorized"))
            // But for now we will show my own trades if the user is not logged in
            // This None will grab the default user_id, which is my account
            None => crate::db::models::users::get_user_from_database_by_ninja_trader_id(&state.db, &"YourNinjaTraderIdString".to_string()).await?.id
        };
    let today = Local::now().date_naive();
    let tomorrow = today + chrono::Duration::try_days(1).unwrap();
    let start_date = match &query.start_date {
        Some(date) => excel_helpers::date_to_excel(&NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(NaiveDate::from_ymd_opt(today.year() - 3, 1, 1).unwrap())),
        _ => excel_helpers::date_to_excel(&NaiveDate::from_ymd_opt(today.year() - 3, 1, 1).unwrap())
    };

    let end_date = match &query.end_date {
        Some(date) => excel_helpers::date_to_excel(&NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(tomorrow)),
        _ => excel_helpers::date_to_excel(&tomorrow)
    };

    // PA trades
    let trade_search_params = trades::TradeSearchParams::default()
        .start_date(start_date)
        .end_date(end_date);
    let trades_by_day = trades::trades_by_hash_for_journal(&state.db, &trade_search_params).await?;

    let mut sorted_keys: Vec<&i32> = trades_by_day.keys().collect();
    sorted_keys.sort();
    sorted_keys.reverse();
    let sorted_trades_by_day: Vec<(&i32, &trades::JournalEntryDayStats)> = sorted_keys.iter().map(|&k| (k, trades_by_day.get(k).unwrap())).collect();

    let mut context = tera::Context::new();
    context.insert("trades_by_day", &sorted_trades_by_day);
    context.insert("google_image_to_markdown_faq_anchor", utils::faq_anchors::GOOGLE_IMAGE_TO_MARKDOWN);
    match render_content(&RenderTemplateParams::new("journal_entries/index.html", &tera_engine)
        .with_context(&context)
        .with_session(&session)
        .with_flash_messages(&flash_messages)) {
        Ok(journal_entry_template) => Ok(HttpResponse::Ok().body(journal_entry_template)),
        Err(e) => Ok(HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e)))
    }
}

/// This route is for journal_entries page to post to
#[tracing::instrument(
    name = "Creating a new user",
    skip(state, session),
    fields(email = %body.entry_date, username = %body.notes)
)]
#[post("")]
pub async fn create_journal_entry(
    state: Data<AppState>,
    body: Form<journal_entries::JournalEntryForm>,
    request: HttpRequest,
    session: TypedSession,
    tera_engine: Data<tera::Tera>
) -> Result<HttpResponse, actix_web::Error> 
{
    let user_id = match session
        .get_user_id()
        .map_err(utils::e500)? {
            Some(user_id) => user_id,
            None => return Ok(HttpResponse::Unauthorized().json("You are not authorized"))
        };
    let journal_entry_insert_params = journal_entries::JournalEntryInsertParams {
        user_id,
        entry_date: body.0.entry_date,
        notes: body.0.notes,
    };
    journal_entries::save_journal_entry_to_database(&state.db, &journal_entry_insert_params).await.map_err(utils::e500)?;
    FlashMessage::success("Journal entry created successfully!").send();
    Ok(HttpResponse::SeeOther().insert_header((LOCATION, "/journal_entries")).finish())
}

#[derive(Debug, Deserialize, Serialize)]
pub struct JournalEntryUpdateParams {
    journal_id: i64,
}

/// This route is for journal_entries page to post to
#[tracing::instrument(
    name = "Creating a new user",
    skip(state, session),
    fields(entry_date = %body.entry_date, notes = %body.notes, id = %params.journal_id)
)]
#[post("{journal_id}")]
pub async fn update_journal_entry(
    state: Data<AppState>,
    params: web::Path<JournalEntryUpdateParams>,
    body: Form<journal_entries::JournalEntryForm>,
    request: HttpRequest,
    session: TypedSession,
    tera_engine: Data<tera::Tera>
) -> Result<HttpResponse, actix_web::Error> 
{
    let user_id = match session
        .get_user_id()
        .map_err(utils::e500)? {
            Some(user_id) => user_id,
            None => return Ok(HttpResponse::Unauthorized().json("You are not authorized"))
        };
    let journal_entry_update_params = journal_entries::JournalEntryUpdateParams {
        id: params.journal_id,
        user_id,
        entry_date: body.0.entry_date,
        notes: body.0.notes,
    };
    journal_entries::update_journal_entry_in_database(&state.db, &journal_entry_update_params).await.map_err(utils::e500)?;
    FlashMessage::success("Journal entry updated successfully!").send();
    Ok(HttpResponse::SeeOther().insert_header((LOCATION, "/journal_entries")).finish())
}

