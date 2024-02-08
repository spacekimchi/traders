//! tests/api/executions.rs
//!
//! Current tests
//!
//! [
//!     {"id":"ea1efabf68cf4be9a3dc344b63e5edf2","account_name":"Sim101","order_id":"ef41669c50854e8fad5dd5bfd766cd6a","instrument_name":"ES","fill_time":45329.840480127314,"commission":2.09,"price":5012.25,"position":1,"is_buy":true,"quantity":1,"is_entry":true,"is_exit":false},
//!     {"id":"48c3dbc37fe242c490884f1340143909","account_name":"Sim101","order_id":"ede9aedac1a14d98ab255e64a9cbe467","instrument_name":"ES","fill_time":45329.840523148145,"commission":2.09,"price":5012.25,"position":0,"is_buy":false,"quantity":1,"is_entry":false,"is_exit":true}
//! ]
//!
//!

use crate::helpers::spawn_app;

#[actix_web::test]
async fn execution_create_success() {
    let app = spawn_app().await;
    let body = serde_json::json!([
    ]);
    let response = app.post_ninja_trader_executions_import(&body).await;
    assert_eq!(401, response.status().as_u16());
}
