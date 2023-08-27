//! tests/api/users.rs
//!
//! Current tests
//!   1. unauthorized_user_creation
//!   2. authorized_user_creationg
//!

use crate::helpers::spawn_app;

#[actix_web::test]
async fn unauthorized_user_creation() {
    let app = spawn_app().await;
    let body = serde_json::json!({
            "username": "test_user1",
            "email": "test1@email.com",
            "password": "newpassword",
        });
    
    let response = app.post_users(&body).await;

    assert_eq!(401, response.status().as_u16());
}

#[actix_web::test]
async fn authorized_user_creation() {
    let app = spawn_app().await;
    let body = serde_json::json!({
            "username": "test_user1",
            "email": "test1@email.com",
            "password": "newpassword",
        });
    let response = app.post_users_form(&body).await;

    assert_eq!(401, response.status().as_u16());

    let login_body = serde_json::json!({
        "username": &app.test_user.username,
        "password": &app.test_user.password
    });
    let _response = app.post_login(&login_body).await;
    let response = app.post_users_form(&body).await;

    assert_eq!(303, response.status().as_u16(), "User creation failed");
}

