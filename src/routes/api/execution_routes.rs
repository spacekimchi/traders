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
//
// {"ninja_trader_id":"YourNinjaTraderIdString","executions":[{"execution_id":"1286157|1157396005|1157396005","account_name":"PA-APEX-30411-08","order_id":"1157396005","ticker":"ES","fill_time":45369.441948321757,"commission":2.09,"price":5230.25,"position":1,"is_buy":true,"quantity":1,"is_entry":true,"is_exit":false},{"execution_id":"1294412|1157460562|1157460562","account_name":"PA-APEX-30411-08","order_id":"1157460562","ticker":"ES","fill_time":45369.443360011574,"commission":2.09,"price":5231.75,"position":0,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true},{"execution_id":"1668016|1159151198|1159151198","account_name":"PA-APEX-30411-08","order_id":"1159151198","ticker":"ES","fill_time":45369.525759282405,"commission":2.09,"price":5229,"position":-1,"is_buy":false,"quantity":1,"is_entry":true,"is_exit":false},{"execution_id":"1679297|1159151488|1159151488","account_name":"PA-APEX-30411-08","order_id":"1159151488","ticker":"ES","fill_time":45369.526259814818,"commission":2.09,"price":5228,"position":0,"is_buy":true,"quantity":1,"is_entry":false,"is_exit":true},{"execution_id":"1708569|1159223252|1159223252","account_name":"PA-APEX-30411-08","order_id":"1159223252","ticker":"ES","fill_time":45369.532175636574,"commission":2.09,"price":5229,"position":-1,"is_buy":false,"quantity":1,"is_entry":true,"is_exit":false},{"execution_id":"1696694|1159223327|1159223327","account_name":"PA-APEX-30411-08","order_id":"1159223327","ticker":"ES","fill_time":45369.533294895831,"commission":2.09,"price":5228.75,"position":0,"is_buy":true,"quantity":1,"is_entry":false,"is_exit":true},{"execution_id":"1286254|1157396140|1157396140","account_name":"PA-APEX-30411-09","order_id":"1157396140","ticker":"ES","fill_time":45369.4419484375,"commission":2.09,"price":5230.25,"position":1,"is_buy":true,"quantity":1,"is_entry":true,"is_exit":false},{"execution_id":"1293639|1157460598|1157460598","account_name":"PA-APEX-30411-09","order_id":"1157460598","ticker":"ES","fill_time":45369.44336,"commission":2.09,"price":5231.75,"position":0,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true},{"execution_id":"1691580|1159151216|1159151216","account_name":"PA-APEX-30411-09","order_id":"1159151216","ticker":"ES","fill_time":45369.525759282405,"commission":2.09,"price":5229,"position":-1,"is_buy":false,"quantity":1,"is_entry":true,"is_exit":false},{"execution_id":"1674746|1159151494|1159151494","account_name":"PA-APEX-30411-09","order_id":"1159151494","ticker":"ES","fill_time":45369.526259814818,"commission":2.09,"price":5228,"position":0,"is_buy":true,"quantity":1,"is_entry":false,"is_exit":true},{"execution_id":"1708570|1159223266|1159223266","account_name":"PA-APEX-30411-09","order_id":"1159223266","ticker":"ES","fill_time":45369.532175636574,"commission":2.09,"price":5229,"position":-1,"is_buy":false,"quantity":1,"is_entry":true,"is_exit":false},{"execution_id":"1692033|1159223337|1159223337","account_name":"PA-APEX-30411-09","order_id":"1159223337","ticker":"ES","fill_time":45369.533294895831,"commission":2.09,"price":5228.75,"position":0,"is_buy":true,"quantity":1,"is_entry":false,"is_exit":true}]}

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
    pub fill_time: f64,
    pub commission: f32,
    pub price: f32,
    pub position: i32,
    pub is_buy: bool,
    pub quantity: i64,
    pub is_entry: bool,
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
    let db = state.db.clone(); // Clone the pool reference
    let user_id = user.id.clone(); // Clone the Uuid

    spawn_with_tracing(async move {
        match trade_processor::process_ninja_trader_executions_and_trades(&db, &user_id, &executions_data).await {
            Ok(_) => {},
            Err(ProcessingError::Execution(e)) => eprintln!("Encountered an execution error: {}", e),
            Err(ProcessingError::Trade(e)) => eprintln!("Encountered a trade error: {}", e),
        }
    });
    Ok(HttpResponse::Created().json("Successfully received executions and started processing."))
}
