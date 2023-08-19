//! src/routes/calendar/mod.rs
//!
//! This directory will hold all the files that have to do with pages under the /calendar url
//! Routes under this directory should be placed under the /calendar namespace in src/startup.rs
//!

use actix_web::{HttpResponse, get};
use actix_web::web::{Data, Query};
use handlebars::Handlebars;
use serde_json::json;

use crate::session_state::TypedSession;
use crate::startup::AppState;
use crate::template_helpers::{render_content, RenderTemplateParams, err_500_template};
use crate::db::models::{trades, TradeQuery};

/// https://traders.jinz.co/calendar
#[get("")]
async fn get_calendar_root(hb: Data<Handlebars<'_>>, _session: TypedSession, state: Data<AppState>, tq: Query<TradeQuery>) -> HttpResponse {
    let trades = trades::get_trades(&state, &tq).await;
    println!("\n\n\nTRADES: {:#?}\n\n\n", trades);
    let calendar_root_data = json!({});
    match render_content(&RenderTemplateParams::new("calendar/index", &hb)) {
        Ok(calendar_template) => HttpResponse::Ok().body(calendar_template),
        Err(e) => HttpResponse::InternalServerError().body(err_500_template(&hb, e))
    }
}
