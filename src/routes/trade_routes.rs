//! src/routes/trade_routes.rs
//!

use actix_web::web::{Data, Query};
use actix_web::http;
use actix_web::{HttpResponse, get, post};
use chrono::{Datelike, NaiveDate, Local};
use serde::{Serialize, Deserialize};

use crate::startup::AppState;
use crate::session_state::TypedSession;
use crate::template_helpers::{render_content, RenderTemplateParams, err_500_template};
use crate::db::models::trades;
use crate::excel_helpers;
use crate::services::trade_processor;
use crate::utils::e500;

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
            NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(NaiveDate::from_ymd_opt(today.year() - 3, 1, 1).unwrap())
        },
        _ => {
            NaiveDate::from_ymd_opt(today.year() - 3, 1, 1).unwrap()
        }
    };
    let tomorrow = today + chrono::Duration::try_days(1).unwrap();

    let end_date = match &query.end_date {
        Some(date) => {
            NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(tomorrow)
        },
        _ => tomorrow
    };
    // For now, just grab all the trades. Later we can add a filter for dates.
    let trades_in_range = match trades::get_trades_for_table_in_range(&state.db, excel_helpers::date_to_excel(&start_date), excel_helpers::date_to_excel(&end_date)).await {
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

/// URL: https://traders.jinz.co/process_trades
#[post("process_trades")]
async fn process_trades(session: TypedSession, state: Data<AppState>) -> Result<HttpResponse, actix_web::Error> {
    let user_id = match session
        .get_user_id()
        .map_err(e500)? {
            Some(user_id) => user_id,
            None => return Ok(HttpResponse::Unauthorized().body("You are not authorized"))
        };
    trade_processor::process_trades(&state.db, &user_id).await.map_err(e500)?;
    Ok(HttpResponse::Found().insert_header((http::header::LOCATION, "/trades")).finish())
}
