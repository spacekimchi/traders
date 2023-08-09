use actix_web::{HttpResponse, Responder, get};

#[get("/health_check")]
pub async fn health_check() -> impl Responder {
    println!("AM I HITTING THIS ENDPOINT");
    HttpResponse::Ok().finish()
}

