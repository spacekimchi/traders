use actix_web::{HttpResponse, post, Responder};
use actix_web::web::Data;
use serde::Deserialize;

use crate::startup::AppState;
use crate::db::models::executions;
use crate::telemetry::spawn_with_tracing;
use crate::db::models::users::get_user_from_database_by_ninja_trader_id;

// Sample executions that will be sent from the NinjaTrader backend
// These are from real trades. Write test cases around these
// [
//   {"id":"ea1efabf68cf4be9a3dc344b63e5edf2","account_name":"Sim101","order_id":"ef41669c50854e8fad5dd5bfd766cd6a","instrument_name":"ES","fill_time":45329.840480127314,"commission":2.09,"price":5012.25,"position":1,"is_buy":true,"quantity":1,"is_entry":true,"is_exit":false},
//   {"id":"48c3dbc37fe242c490884f1340143909","account_name":"Sim101","order_id":"ede9aedac1a14d98ab255e64a9cbe467","instrument_name":"ES","fill_time":45329.840523148145,"commission":2.09,"price":5012.25,"position":0,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true}
// ]
//
//
// [
//   {"id":"5322440|1022167948|1022167948","account_name":"APEX-30411-34","order_id":"1022167948","instrument_name":"ES","fill_time":45330.408249166663,"commission":6.27,"price":5011,"position":3,"is_buy":true,"quantity":3,"is_entry":true,"is_exit":false},
//   {"id":"5322442|1022167948|1022167948","account_name":"APEX-30411-34","order_id":"1022167948","instrument_name":"ES","fill_time":45330.408249224536,"commission":14.629999999999999,"price":5011,"position":10,"is_buy":true,"quantity":7,"is_entry":true,"is_exit":false},
//   {"id":"5344734|1022302723|1022302723","account_name":"APEX-30411-34","order_id":"1022302723","instrument_name":"ES","fill_time":45330.410923171294,"commission":20.9,"price":5012,"position":0,"is_buy":false,"quantity":10,"is_entry":false,"is_exit":true}
// ]
//
// [
//   {"id":"6438512|1025474200|1025474200","account_name":"APEX-30411-34","order_id":"1025474200","instrument_name":"ES","fill_time":45331.35844640046,"commission":20.9,"price":5036.25,"position":10,"is_buy":true,"quantity":10,"is_entry":true,"is_exit":false},
//   {"id":"6433055|1025474828|1025474828","account_name":"APEX-30411-34","order_id":"1025474828","instrument_name":"ES","fill_time":45331.358538113425,"commission":4.18,"price":5037.25,"position":8,"is_buy":false,"quantity":2,"is_entry":false,"is_exit":true},
//   {"id":"6433057|1025474828|1025474828","account_name":"APEX-30411-34","order_id":"1025474828","instrument_name":"ES","fill_time":45331.358538113425,"commission":4.18,"price":5037.25,"position":6,"is_buy":false,"quantity":2,"is_entry":false,"is_exit":true},
//   {"id":"6433059|1025474828|1025474828","account_name":"APEX-30411-34","order_id":"1025474828","instrument_name":"ES","fill_time":45331.358538125,"commission":2.09,"price":5037.25,"position":5,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true},
//   {"id":"6433061|1025474828|1025474828","account_name":"APEX-30411-34","order_id":"1025474828","instrument_name":"ES","fill_time":45331.358538125,"commission":4.18,"price":5037.25,"position":3,"is_buy":false,"quantity":2,"is_entry":false,"is_exit":true},
//   {"id":"6433063|1025474828|1025474828","account_name":"APEX-30411-34","order_id":"1025474828","instrument_name":"ES","fill_time":45331.358538125,"commission":2.09,"price":5037.25,"position":2,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true},
//   {"id":"6433065|1025474828|1025474828","account_name":"APEX-30411-34","order_id":"1025474828","instrument_name":"ES","fill_time":45331.358538125,"commission":2.09,"price":5037.25,"position":1,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true},
//   {"id":"6433067|1025474828|1025474828","account_name":"APEX-30411-34","order_id":"1025474828","instrument_name":"ES","fill_time":45331.358538136577,"commission":2.09,"price":5037.25,"position":0,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true},
//   {"id":"6791313|1026463397|1026463397","account_name":"APEX-30411-34","order_id":"1026463397","instrument_name":"ES","fill_time":45331.427462916668,"commission":20.9,"price":5027,"position":10,"is_buy":true,"quantity":10,"is_entry":true,"is_exit":false},
//   {"id":"6762370|1026475291|1026475291","account_name":"APEX-30411-34","order_id":"1026475291","instrument_name":"ES","fill_time":45331.428408726853,"commission":14.629999999999999,"price":5027.25,"position":3,"is_buy":false,"quantity":7,"is_entry":false,"is_exit":true},
//   {"id":"6762371|1026475291|1026475291","account_name":"APEX-30411-34","order_id":"1026475291","instrument_name":"ES","fill_time":45331.428408738429,"commission":2.09,"price":5027.25,"position":2,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true},
//   {"id":"6762372|1026475291|1026475291","account_name":"APEX-30411-34","order_id":"1026475291","instrument_name":"ES","fill_time":45331.42840875,"commission":2.09,"price":5027.25,"position":1,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true},
//   {"id":"6762373|1026475291|1026475291","account_name":"APEX-30411-34","order_id":"1026475291","instrument_name":"ES","fill_time":45331.42840875,"commission":2.09,"price":5027.25,"position":0,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true},
//   {"id":"7372772|1028168816|1028168816","account_name":"APEX-30411-34","order_id":"1028168816","instrument_name":"ES","fill_time":45331.632758807871,"commission":20.9,"price":5043,"position":-10,"is_buy":false,"quantity":10,"is_entry":true,"is_exit":false},
//   {"id":"7393694|1028169127|1028169127","account_name":"APEX-30411-34","order_id":"1028169127","instrument_name":"ES","fill_time":45331.633897916669,"commission":20.9,"price":5042.75,"position":0,"is_buy":true,"quantity":10,"is_entry":false,"is_exit":true},
//   {"id":"7362104|1028178480|1028178480","account_name":"APEX-30411-34","order_id":"1028178480","instrument_name":"ES","fill_time":45331.634491053243,"commission":20.9,"price":5042.25,"position":-10,"is_buy":false,"quantity":10,"is_entry":true,"is_exit":false},
//   {"id":"7392263|1028179127|1028179127","account_name":"APEX-30411-34","order_id":"1028179127","instrument_name":"ES","fill_time":45331.644167453705,"commission":6.27,"price":5042,"position":-7,"is_buy":true,"quantity":3,"is_entry":false,"is_exit":true},
//   {"id":"7392284|1028179127|1028179127","account_name":"APEX-30411-34","order_id":"1028179127","instrument_name":"ES","fill_time":45331.644179224539,"commission":14.629999999999999,"price":5042,"position":0,"is_buy":true,"quantity":7,"is_entry":false,"is_exit":true},
//   {"id":"7393102|1028272790|1028272790","account_name":"APEX-30411-34","order_id":"1028272790","instrument_name":"ES","fill_time":45331.654399884261,"commission":20.9,"price":5041,"position":10,"is_buy":true,"quantity":10,"is_entry":true,"is_exit":false},
//   {"id":"7404736|1028272997|1028272997","account_name":"APEX-30411-34","order_id":"1028272997","instrument_name":"ES","fill_time":45331.660325787037,"commission":20.9,"price":5041.25,"position":0,"is_buy":false,"quantity":10,"is_entry":false,"is_exit":true},
//   {"id":"7423841|1028308085|1028308085","account_name":"APEX-30411-34","order_id":"1028308085","instrument_name":"ES","fill_time":45331.661490104168,"commission":20.9,"price":5042,"position":10,"is_buy":true,"quantity":10,"is_entry":true,"is_exit":false},
//   {"id":"7408002|1028308393|1028308393","account_name":"APEX-30411-34","order_id":"1028308393","instrument_name":"ES","fill_time":45331.661638564816,"commission":6.27,"price":5042.25,"position":7,"is_buy":false,"quantity":3,"is_entry":false,"is_exit":true},
//   {"id":"7408009|1028308393|1028308393","account_name":"APEX-30411-34","order_id":"1028308393","instrument_name":"ES","fill_time":45331.6616434838,"commission":14.629999999999999,"price":5042.25,"position":0,"is_buy":false,"quantity":7,"is_entry":false,"is_exit":true},
//   {"id":"7451032|1028312929|1028312929","account_name":"APEX-30411-34","order_id":"1028312929","instrument_name":"ES","fill_time":45331.662320601848,"commission":20.9,"price":5042.75,"position":-10,"is_buy":false,"quantity":10,"is_entry":true,"is_exit":false},
//   {"id":"7408390|1028313121|1028313121","account_name":"APEX-30411-34","order_id":"1028313121","instrument_name":"ES","fill_time":45331.662508368056,"commission":8.36,"price":5042.25,"position":-6,"is_buy":true,"quantity":4,"is_entry":false,"is_exit":true},
//   {"id":"7408391|1028313121|1028313121","account_name":"APEX-30411-34","order_id":"1028313121","instrument_name":"ES","fill_time":45331.662508368056,"commission":2.09,"price":5042.25,"position":-5,"is_buy":true,"quantity":1,"is_entry":false,"is_exit":true},
//   {"id":"7408392|1028313121|1028313121","account_name":"APEX-30411-34","order_id":"1028313121","instrument_name":"ES","fill_time":45331.662508368056,"commission":10.45,"price":5042.25,"position":0,"is_buy":true,"quantity":5,"is_entry":false,"is_exit":true},
//   {"id":"7432343|1028322997|1028322997","account_name":"APEX-30411-34","order_id":"1028322997","instrument_name":"ES","fill_time":45331.665271006947,"commission":20.9,"price":5043,"position":10,"is_buy":true,"quantity":10,"is_entry":true,"is_exit":false},
//   {"id":"7452856|1028333658|1028333658","account_name":"APEX-30411-34","order_id":"1028333658","instrument_name":"ES","fill_time":45331.665813101848,"commission":20.9,"price":5043.25,"position":0,"is_buy":false,"quantity":10,"is_entry":false,"is_exit":true}
// ]
//
//
//

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
    pub instrument_name: String,
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
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    let ninja_trader_data = ninja_trader_import.into_inner();

    let ninja_trader_id = ninja_trader_data.ninja_trader_id;
    let executions_data = ninja_trader_data.executions;
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    println!("Received ninja_trader_id: {:?}", ninja_trader_id);
    println!("Received executions_data: {:?}", executions_data);
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    // Attempt to retrieve the user associated with the given Ninja Trader ID
    // This will return an Http Error if it is unable to find a user
    let user = get_user_from_database_by_ninja_trader_id(&state, &ninja_trader_id).await?;

    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    println!("user: {:?}", user);
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    println!("XXXXXXXXXXXX INSIDE NINJA_TRADER_EXECUTIONS XXXXXXXXXXXXXXXX");
    spawn_with_tracing(async move {
        match executions::save_executions_from_ninja_trader_to_database(&state.db, user.id, &executions_data).await {
            Ok(_) => println!("Executions saved successfully."),
            Err(e) => eprintln!("Failed to save executions: {:?}", e),
        }
    });
    Ok(HttpResponse::Created().json("Successfully received executions and started processing."))
}
