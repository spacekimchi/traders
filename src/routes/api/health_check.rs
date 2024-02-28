//! src/routes/health_check.rs
//! This file holds endpoints for checking on the status of the server

// External crate imports
use actix_web::{HttpResponse, Responder, get, post};

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

#[post("/health_check")]
pub async fn health_check_post() -> impl Responder {
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK POST XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK POST XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK POST XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE OF HEALTH CHECK POST XXXXXXXXXXXXXXXX");
    HttpResponse::InternalServerError().json("THIS IS A json 500 ERROR")
}
