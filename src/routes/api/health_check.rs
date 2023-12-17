//! src/routes/health_check.rs
//! This file holds endpoints for checking on the status of the server

// External crate imports
use actix_web::{HttpResponse, Responder, get, post};
use actix_web::web::{Data, Json, Path, Form};
use serde::Deserialize;
use crate::startup::AppState;
use secrecy::{Secret, ExposeSecret};

/// a health_check endpoint to check on the health of the server
///
/// # Arguments
///
/// # Returns:
/// returns an HttpResponse with status (ok) 200
///   - HttpResponse::Ok() is a builder pattern, and .finish() tells
///     the builder to finalize the response. We can also use something
///     like HttpResponse::Ok().body("Message in a body"). The .body() method
///     also finalizes the response
#[get("/health_check")]
pub async fn health_check() -> impl Responder {
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK XXXXXXXXXXXXXXXX");
    HttpResponse::Ok().finish()
}

#[derive(Debug, Deserialize)]
pub struct ExecutionJsonData {
    order_id: String,
}

#[post("/health_check_posts")]
pub async fn health_check_posts(
    state: Data<AppState>,
    executions: actix_web::web::Json<Vec<ExecutionJsonData>>,
) -> impl Responder {
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK POSTS XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK POSTS XXXXXXXXXXXXXXXX");
    println!("Received: {:?}", executions);
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK POSTS XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK POSTS XXXXXXXXXXXXXXXX");
    HttpResponse::Ok().json("Data Received")
}

