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
use crate::excel_helpers;
use crate::startup::AppState;
use crate::template_helpers::{render_content, RenderTemplateParams, err_500_template};
use crate::db::models::{trades, TradeQuery, TradeInfoByDay};

/// https://traders.jinz.co/calendar
#[get("")]
async fn get_calendar_root(hb: Data<Handlebars<'_>>, _session: TypedSession, state: Data<AppState>, tq: Query<TradeQuery>) -> HttpResponse {
    let this_year = excel_helpers::get_current_year();

    match trades::get_trades_by_day_in_year(&state, this_year).await {
        Ok(trades_by_day) => {
            println!("\n\n\nTRADES_BY_DAY: {:?}\n\n\n", trades_by_day);
            let mini_months = vec!([1, 2, 3, 4, 5, 6]);
            // Do something with trades_by_day if needed
            let calendar_index_data = json!({
                "trades": trades_by_day,
                "mini_months": mini_months
            });
            match render_content(&RenderTemplateParams::new("calendar/index", &hb).with_data(&calendar_index_data)) {
                Ok(calendar_template) => HttpResponse::Ok().body(calendar_template),
                Err(e) => HttpResponse::InternalServerError().body(err_500_template(&hb, e))
            }
        },
        Err(e) => HttpResponse::InternalServerError().body(err_500_template(&hb, e))
    }
}
