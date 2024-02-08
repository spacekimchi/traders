use actix_web::{HttpResponse, Responder, get, post};
use actix_web::web::Data;
use serde::Deserialize;

use crate::startup::AppState;

// Sample executions that will be sent from the NinjaTrader backend
// [
     //{"id":"ea1efabf68cf4be9a3dc344b63e5edf2","account_name":"Sim101","order_id":"ef41669c50854e8fad5dd5bfd766cd6a","instrument_name":"ES","fill_time":45329.840480127314,"commission":2.09,"price":5012.25,"position":1,"is_buy":true,"quantity":1,"is_entry":true,"is_exit":false},
     //{"id":"48c3dbc37fe242c490884f1340143909","account_name":"Sim101","order_id":"ede9aedac1a14d98ab255e64a9cbe467","instrument_name":"ES","fill_time":45329.840523148145,"commission":2.09,"price":5012.25,"position":0,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true}
// ]

#[derive(Debug, Deserialize)]
pub struct ExecutionJsonData {
    id: String,
    account_name: String,
    order_id: String,
    instrument_name: String,
    fill_time: f64, // Need to convert this to TIMESTAMPTZ
    commission: f32,
    price: f32,
    position: i32,
    is_buy: bool,
    quantity: i64,
    is_entry: bool,
    is_exit: bool,
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
