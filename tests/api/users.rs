//! tests/users.rs
use crate::helpers::{spawn_app, TestApp};
use uuid::Uuid;

/*
 * [] create user
 * [] get single user
 * [] get users
 * [] create user
 * [] delete user
 */

#[actix_web::test]
async fn requests_missing_authorization_are_rejected() {
    let app = spawn_app().await;
    
    let response = reqwest::Client::new()
        .post(&format!("{}/users", &app.address))
        .json(&serde_json::json!({
            "username": "test_user",
            "email": "test@email.com",
        }))
        .send()
        .await
        .expect("Failed to execute request.");

    // Assert
    assert_eq!(401, response.status().as_u16());
    assert_eq!(r#"Basic realm="user""#, response.headers()["WWW-Authenticate"]);
}

#[actix_web::test]
async fn new_user_is_created() {
    let app = spawn_app().await;
    let body = serde_json::json!({
            "username": "test_user1",
            "email": "test1@email.com",
            "password_hash": "newpassword",
        });
    
    let response = app.post_users(&body).await;

    // Assert
    assert_eq!(200, response.status().as_u16());
}

#[actix_web::test]
async fn non_existing_user_is_rejected() {
    // Arrange
    let app = spawn_app().await;
    // Random credentials
    let username = uuid::Uuid::new_v4().to_string();
    let password = uuid::Uuid::new_v4().to_string();

    let response = reqwest::Client::new()
        .post(&format!("{}/users", &app.address))
        .basic_auth(username, Some(password))
        .json(&serde_json::json!({
            "username": "Newslettere",
            "email": "asdkfs",
            "password_hash": "asdfsfd"
        }))
        .send()
        .await
        .expect("Failed to execute request.");

    // Assert
    assert_eq!(401, response.status().as_u16());
    assert_eq!(
        r#"Basic realm="user""#,
        response.headers()["WWW-Authenticate"]
    );
}

#[actix_web::test]
async fn invalid_password_is_rejected() {
    // Arrange
    let app = spawn_app().await;
    let username = &app.test_user.username;
    // Random password
    let password = Uuid::new_v4().to_string();
    assert_ne!(app.test_user.password, password);

    let response = reqwest::Client::new()
        .post(&format!("{}/users", &app.address))
        .basic_auth(username, Some(password))
        .json(&serde_json::json!({
            "username": "ewslettere",
            "email": "asdfs",
            "password_hash": "asdfsfd"
        }))
        .send()
        .await
        .expect("Failed to execute request.");

    // Assert
    assert_eq!(401, response.status().as_u16());
    assert_eq!(
        r#"Basic realm="user""#,
        response.headers()["WWW-Authenticate"]
    );
}

