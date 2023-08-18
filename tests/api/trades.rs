//! tests/api/trades.rs
//!
//! Tests needed:
//!   - [ ] Able to get a list of trades within a date range
//!
//! Maybe implement these later
//!   - [ ] Able to get a single trade by id
//!   - [ ] Able to get trades based on a filter (Maybe for later)
//!   - [ ] Trade is able to successfully create (Not needed actually)
//!
use crate::helpers::{spawn_app, TestApp};
use uuid::Uuid;

use crate::helpers::spawn_app;

#[actix_web::test]
async fn get_trade_in_time_range() {
    let app = spawn_app().await;

    let login_body = serde_json::json!({
        "username": &app.test_user.username,
        "password": &app.test_user.password
    });

    let response = app.post_login(&login_body).await;

    assert_eq!(401, response.status().as_u16());
}

#[actix_web::test]
async fn get_trade_with_filters() {
    let app = spawn_app().await;

    let login_body = serde_json::json!({
        "username": &app.test_user.username,
        "password": &app.test_user.password
    });

    let response = app.post_login(&login_body).await;

    assert_eq!(401, response.status().as_u16());
}


#[actix_web::test]
async fn get_trade_by_id() {
    let app = spawn_app().await;

    let login_body = serde_json::json!({
        "username": &app.test_user.username,
        "password": &app.test_user.password
    });

    let response = app.post_login(&login_body).await;

    assert_eq!(401, response.status().as_u16());
}

