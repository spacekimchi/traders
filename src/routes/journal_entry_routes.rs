//! src/routes/journal_entry_routes.rs
//!
//! This file is for all the routes contained under the traders.jinz.co/journal_entries url.

use actix_web::{web, HttpResponse, get};
use serde::{Serialize, Deserialize};
use chrono::{Datelike, NaiveDate, Local};

use crate::session_state::TypedSession;
use crate::startup::AppState;
use crate::db::models::trades;
use crate::excel_helpers;
use crate::template_helpers::{RenderTemplateParams, err_500_template, render_content};

/// The start_date and end_date formats should be "YEAR-MONTH-DAY" (2023-12-31)
#[derive(Debug, Serialize, Deserialize)]
pub struct JournalEntryIndexQueryStrings {
    pub start_date: Option<String>,
    pub end_date: Option<String>,
}

#[get("")]
pub async fn get_journal_entries_index(state: web::Data<AppState>, session: TypedSession, tera_engine: web::Data<tera::Tera>, query: web::Query<JournalEntryIndexQueryStrings>) -> Result<HttpResponse, actix_web::Error> {
    let _user_id = match session.get_user_id() {
        Ok(user_id) => user_id,
        Err(_e) => return Ok(HttpResponse::Unauthorized().body("You are unauthorized"))
    };
    let today = Local::now().date_naive();
    let start_date = match &query.start_date {
        Some(date) => excel_helpers::date_to_excel(&NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(NaiveDate::from_ymd_opt(today.year() - 3, 1, 1).unwrap())),
        _ => excel_helpers::date_to_excel(&NaiveDate::from_ymd_opt(today.year() - 3, 1, 1).unwrap())
    };

    let end_date = match &query.end_date {
        Some(date) => excel_helpers::date_to_excel(&NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(today)),
        _ => excel_helpers::date_to_excel(&today)
    };
    let trades_by_range = trades::get_trades_by_day_in_range(&state.db, start_date, end_date).await?;
    let mut context = tera::Context::new();
    context.insert("trades_by_day", &trades_by_range);
    match render_content(&RenderTemplateParams::new("journal_entries/index.html", &tera_engine)
                         .with_context(&context)
                         .with_session(&session)) {
        Ok(calendar_template) => Ok(HttpResponse::Ok().body(calendar_template)),
        Err(e) => Ok(HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e)))
    }
}
