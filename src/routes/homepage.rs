//! src/routes/homepage.rs
//!
//! This file is used to create a route for the homepage
use actix_web::{get, HttpResponse, web};
use actix_web_flash_messages::IncomingFlashMessages;

use crate::template_helpers::{RenderTemplateParams, render_content};

// Macro documentation can be found in the actix_web_codegen crate
#[get("/")]
async fn index(tera_store: web::Data<tera::Tera>, flash_messages: IncomingFlashMessages) -> Result<HttpResponse, actix_web::Error> {
    let mut context = tera::Context::new();
    context.insert("name", "traderz");

    let content = render_content(&RenderTemplateParams::new(&"index.html", &tera_store).with_flash_messages(&flash_messages).with_context(&context))?;

    Ok(HttpResponse::Ok().content_type("text/html").body(content))
}
