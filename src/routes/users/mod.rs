use actix_web::{web::Data, HttpResponse, get};
use actix_web_flash_messages::IncomingFlashMessages;
use handlebars::Handlebars;

use crate::template_helpers::{render_content, RenderTemplateParams, err_500_template};

#[tracing::instrument(
    name = "New user page",
    skip(hb, flash_messages),
)]
#[get("/new")]
pub async fn new_user_page(hb: Data<Handlebars<'_>>, flash_messages: IncomingFlashMessages) -> HttpResponse {
    match render_content(&RenderTemplateParams::new("users/new", &hb).with_flash_messages(&flash_messages)) {
        Ok(new_user_page_template) => HttpResponse::Ok().body(new_user_page_template),
        Err(e) => HttpResponse::InternalServerError().body(err_500_template(&hb, e))
    }
}
