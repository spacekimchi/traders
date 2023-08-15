//! src/routes/homepage.rs
//!
//! This file is used to create a route for the homepage
use std::fmt::Write;
use actix_web::{get, HttpResponse, web};
use actix_web_flash_messages::IncomingFlashMessages;
use handlebars::Handlebars;
use serde_json::json;

// Macro documentation can be found in the actix_web_codegen crate
#[get("/")]
async fn index(hb: web::Data<Handlebars<'_>>, flash_messages: IncomingFlashMessages) -> HttpResponse {
    let mut flash_html = String::new();
    for m in flash_messages.iter() {
        writeln!(flash_html, "<div>{}<div>", m.content()).unwrap();
    }
    let content = hb.render("index", &json!({"name": "traderz",})).unwrap();
    let data = json!({
        "flash_html": flash_html,
        "content": content,
    });
    let body = hb.render("base", &data).unwrap();

    HttpResponse::Ok().body(body)
}
