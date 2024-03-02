//! src/routes/trade_routes.rs
//!

use actix_web::web::{Data, Query};
use actix_web::{HttpResponse, get};
use chrono::{Datelike, NaiveDate, Local};
use serde::{Serialize, Deserialize};

use crate::startup::AppState;
use crate::session_state::TypedSession;
use crate::template_helpers::{render_content, RenderTemplateParams, err_500_template};
use crate::utils::{naivedate_to_datetime_utc_start_of_day, naivedate_to_datetime_utc_end_of_day};

use crate::db::models::trades;

/// The start_date and end_date formats should be "YEAR-MONTH-DAY" (2023-12-31)
#[derive(Debug, Serialize, Deserialize)]
pub struct TradeIndexQueryStrings {
    pub start_date: Option<String>,
    pub end_date: Option<String>,
}

/// URL: https://traders.jinz.co/trades
#[get("")]
async fn get_trades_index(tera_engine: Data<tera::Tera>, session: TypedSession, state: Data<AppState>, query: Query<TradeIndexQueryStrings>) -> HttpResponse {
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
    // For now, just grab all the trades. Later we can add a filter for dates.
    let trades_in_range = match trades::get_trades_for_table_in_range(&state.db, &start_date, &end_date).await {
        Ok(trades_by_day_in_range) => trades_by_day_in_range,
        Err(e) => return HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e))
    };

    let mut context = tera::Context::new();
    context.insert("trades_in_range", &trades_in_range);
    match render_content(&RenderTemplateParams::new("trades/index.html", &tera_engine)
                         .with_context(&context)
                         .with_session(&session)) {
        Ok(calendar_template) => HttpResponse::Ok().body(calendar_template),
        Err(e) => HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e))
    }
}

