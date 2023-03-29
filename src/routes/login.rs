use actix_web::http::header::LOCATION;
use actix_web::{HttpResponse, post};

#[post("/login")]
pub async fn login() -> HttpResponse {
    HttpResponse::SeeOther()
        .insert_header((LOCATION, "/trades/month"))
        .finish()
}
