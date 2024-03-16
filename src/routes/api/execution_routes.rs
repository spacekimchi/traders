use actix_web::{HttpResponse, post, Responder};
use actix_web::web::Data;
use serde::Deserialize;

use crate::startup::AppState;
use crate::telemetry::spawn_with_tracing;
use crate::db::models::users::get_user_from_database_by_ninja_trader_id;
use crate::services::trade_processor;
use crate::errors::processing_errors::ProcessingError;

// Sample executions that will be sent from the NinjaTrader backend
// These are from real trades. Write test cases around these
// [
//   {"id":"ea1efabf68cf4be9a3dc344b63e5edf2","account_name":"Sim101","order_id":"ef41669c50854e8fad5dd5bfd766cd6a","instrument_name":"ES","fill_time":45329.840480127314,"commission":2.09,"price":5012.25,"position":1,"is_buy":true,"quantity":1,"is_entry":true,"is_exit":false},
//   {"id":"48c3dbc37fe242c490884f1340143909","account_name":"Sim101","order_id":"ede9aedac1a14d98ab255e64a9cbe467","instrument_name":"ES","fill_time":45329.840523148145,"commission":2.09,"price":5012.25,"position":0,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true}
// ]

/// This is the JSON that is expected from NinjaTrader.
/// fields:
///   ninja_trader_id:
///     This field corresponds to the ninja_trader_id in the Users table.
///     It is a String value that will be used to look up user that the executions belong to.
///   executions:
///     A vector of executions that need to be saved into the database
#[derive(Debug, Deserialize)]
pub struct NinjaTraderImport {
    pub ninja_trader_id: String,
    pub executions: Vec<ExecutionJsonData>,
}

#[derive(Debug, Deserialize)]
pub struct ExecutionJsonData {
    pub account_name: String,
    pub order_id: String,
    // This is the execution_id that NinjaTrader uses
    pub execution_id: String,
    pub ticker: String,
    // Need to convert this to TIMESTAMPTZ
    pub fill_time: f64,
    pub commission: f32,
    pub price: f32,
    pub position: i32,
    pub is_buy: bool,
    pub quantity: i64,
    pub is_entry: bool,
    pub is_exit: bool,
}

/// This endpoint is for saving the executions from NinjaTrader.
/// It should just save the executions, and somehow we need to form trades from them
/// There should also be a way to verify what user the executions belong to.
/// We need a way to connect NinjaTrader accounts with Traders accounts
#[tracing::instrument(name = "NinjaTrader Executions Import", skip(state))]
#[post("/ninja_trader_executions_import")]
pub async fn ninja_trader_executions_import(
    state: Data<AppState>,
    ninja_trader_import: actix_web::web::Json<NinjaTraderImport>,
    ) -> Result<impl Responder, actix_web::Error> {
    let ninja_trader_data = ninja_trader_import.into_inner();

    let ninja_trader_id = ninja_trader_data.ninja_trader_id;
    let executions_data = ninja_trader_data.executions;

    // Attempt to retrieve the user associated with the given Ninja Trader ID
    // This will return an Http Error if it is unable to find a user

    let user = get_user_from_database_by_ninja_trader_id(&state.db, &ninja_trader_id).await?;
    println!("AM I RETURNING A USER: {:?}", user);
    println!("AM I RETURNING A USER: {:?}", user);
    println!("AM I RETURNING A USER: {:?}", user);
    println!("AM I RETURNING A USER: {:?}", user);
    println!("AM I RETURNING A USER: {:?}", user);
    let db = state.db.clone(); // Clone the pool reference
    let user_id = user.id.clone(); // Clone the Uuid

    spawn_with_tracing(async move {
        match trade_processor::process_ninja_trader_executions_and_trades(&db, &user_id, &executions_data).await {
            Ok(_) => {
            },
            Err(ProcessingError::Execution(e)) => eprintln!("Encountered an execution error: {}", e),
            Err(ProcessingError::Trade(e)) => eprintln!("Encountered a trade error: {}", e),
        }
    });
    Ok(HttpResponse::Created().json("Successfully received executions and started processing."))
}
