//! src/routes/calendar/mod.rs
//!
//! This directory will hold all the files that have to do with pages under the /calendar url
//! Routes under this directory should be placed under the /calendar namespace in src/startup.rs
//!

use actix_web::{HttpResponse, get};
use actix_web::web::Data;
use handlebars::Handlebars;

use crate::session_state::TypedSession;
use crate::template_helpers;

/// https://traders.jinz.co/calendar
#[get("")]
async fn get_calendar_root(hb: Data<Handlebars<'_>>, _session: TypedSession) -> HttpResponse {


    match template_helpers::render_content(&template_helpers::RenderTemplateParams::new("calendar", &hb)) {
        Ok(calendar_template) => HttpResponse::Ok().body(calendar_template),
        Err(e) => HttpResponse::InternalServerError().body(template_helpers::err_500_template(&hb, e))
    }
}
