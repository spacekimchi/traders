//! src/routes/journal_entry_routes.rs
//!
//! This file is for all the routes contained under the traders.jinz.co/journal_entries url.

use actix_web::{web, HttpResponse, get};
use serde::{Serialize, Deserialize};
use chrono::{Datelike, NaiveDate, Local};

use crate::utils::{naivedate_to_datetime_utc_start_of_day, naivedate_to_datetime_utc_end_of_day};
use crate::session_state::TypedSession;
use crate::startup::AppState;
use crate::db::models::trades;

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
        Some(date) => {
            let naive_date = NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(NaiveDate::from_ymd_opt(today.year() - 3, 1, 1).unwrap());
            naivedate_to_datetime_utc_start_of_day(&naive_date)
        },
        _ => {
            let naive_date = NaiveDate::from_ymd_opt(today.year() - 3, 1, 1).unwrap();
            naivedate_to_datetime_utc_start_of_day(&naive_date)
        }
    };

    let end_date = match &query.end_date {
        Some(date) => {
            naivedate_to_datetime_utc_end_of_day(&NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(today))
        },
        _ => naivedate_to_datetime_utc_end_of_day(&today)
    };
    let trades = trades::get_trades_by_day_in_range(&state.db, start_date, end_date).await?;
    println!("TRADES_BY_DAY_IN_RANGE: {:?}", trades);


    Ok(HttpResponse::Ok().body(""))
}
