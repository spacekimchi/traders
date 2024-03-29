//! src/routes/execution_routes.rs
//!
//! This file should contain routes related to executions for html endpoints
//!

use actix_web::web::{Data, Query};
use actix_web::{HttpResponse, Responder, get};
use serde::{Serialize, Deserialize};
use chrono::{Datelike, NaiveDate, Local};

use crate::startup::AppState;
use crate::session_state::TypedSession;
use crate::template_helpers::{render_content, RenderTemplateParams, err_500_template};
use crate::utils::e500;
use crate::db::models;
use crate::excel_helpers;

//const DEFAULT_USER_ID: uuid::Uuid = uuid::Uuid::parse_str("6982c6df-3d03-4583-8fa9-07386cf25f80");

/// The start_date and end_date formats should be "YEAR-MONTH-DAY" (2023-12-31)
#[derive(Debug, Serialize, Deserialize)]
pub struct ExecutionsIndexQueryStrings {
    pub start_date: Option<String>,
    pub end_date: Option<String>,
}

#[tracing::instrument(name = "Get Executions Index", skip(tera_engine, state, session))]
#[get("/executions")]
async fn get_executions_index(tera_engine: Data<tera::Tera>, session: TypedSession, state: Data<AppState>, query: Query<ExecutionsIndexQueryStrings>) -> Result<impl Responder, actix_web::Error> {
    let user_id = match session
        .get_user_id()
        .map_err(e500)? {
            Some(user_id) => user_id,
            // This None will grab the default user_id, which is my account
            None => models::users::get_user_from_database_by_ninja_trader_id(&state.db, &"YourNinjaTraderIdString".to_string()).await?.id
        };

    let tomorrow = Local::now().date_naive() + chrono::Duration::try_days(1).unwrap();
    let default_start_year = tomorrow.year() - 3;
    let start_date = match &query.start_date {
        Some(date) => excel_helpers::date_to_excel(&NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(NaiveDate::from_ymd_opt(default_start_year, 1, 1).unwrap())),
        _ => excel_helpers::date_to_excel(&NaiveDate::from_ymd_opt(default_start_year, 1, 1).unwrap())
    };

    let end_date = match &query.end_date {
        Some(date) => excel_helpers::date_to_excel(&NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(tomorrow)),
        _ => excel_helpers::date_to_excel(&tomorrow)
    };

    let executions = models::executions::get_executions_for_index_table(&state.db, &user_id, start_date, end_date).await?;

    let mut context = tera::Context::new();
    context.insert("executions", &executions);
    match render_content(&RenderTemplateParams::new("executions/index.html", &tera_engine)
                         .with_context(&context)
                         .with_session(&session)) {
        Ok(executions_template) => Ok(HttpResponse::Ok().body(executions_template)),
        Err(e) => Ok(HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e)))
    }
}
