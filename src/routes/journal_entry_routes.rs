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
use crate::utils::e500;
use crate::template_helpers::{RenderTemplateParams, err_500_template, render_content};

/// The start_date and end_date formats should be "YEAR-MONTH-DAY" (2023-12-31)
#[derive(Debug, Serialize, Deserialize)]
pub struct JournalEntryIndexQueryStrings {
    pub start_date: Option<String>,
    pub end_date: Option<String>,
}

#[get("")]
pub async fn get_journal_entries_index(state: web::Data<AppState>, session: TypedSession, tera_engine: web::Data<tera::Tera>, query: web::Query<JournalEntryIndexQueryStrings>) -> Result<HttpResponse, actix_web::Error> {
    let _user_id = match session
        .get_user_id()
        .map_err(e500)? {
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
    match render_content(&RenderTemplateParams::new("journal_entries/index.html", &tera_engine)
                         .with_context(&context)
                         .with_session(&session)) {
        Ok(journal_entry_template) => Ok(HttpResponse::Ok().body(journal_entry_template)),
        Err(e) => Ok(HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e)))
    }
}
