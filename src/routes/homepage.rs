//! src/routes/homepage.rs
//!
//! This file is used to create a route for the homepage
use actix_web::{get, HttpResponse, web};
use handlebars::Handlebars;
use serde_json::json;

// Macro documentation can be found in the actix_web_codegen crate
#[get("/")]
async fn index(hb: web::Data<Handlebars<'_>>) -> HttpResponse {
    let data = json!({
        "name": "traderz"
    });
    let body = hb.render("index", &data).unwrap();

    HttpResponse::Ok().body(body)
}
