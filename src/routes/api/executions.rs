use actix_web::{HttpResponse, Responder, get, post};
use actix_web::web::Data;
use serde::Deserialize;

use crate::startup::AppState;

#[derive(Debug, Deserialize)]
pub struct ExecutionJsonData {
    id: i64,
    account_name: String,
    order_id: String,
    instrument_name: String,
    fill_time: f64, // Need to convert this to TIMESTAMPTZ
    commission: f32,
    price: f32,
    is_buy: bool,
    quantity: i64,
}

#[post("/ninja_trader_executions_import")]
pub async fn ninja_trader_executions_import(
    state: Data<AppState>,
    executions: actix_web::web::Json<Vec<ExecutionJsonData>>,
) -> Result<impl Responder, actix_web::Error> {
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    println!("Received: {:?}", executions);
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    Ok(HttpResponse::Created().json("Executions saved"))
}
