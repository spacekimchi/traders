use crate::helpers::{spawn_app, assert_is_redirect_to};

#[actix_web::test]
async fn invalid_user_is_unable_to_login() {
    let app = spawn_app().await;
    let body = serde_json::json!({
            "username": "test_user1",
            "password": "password",
        });
    
    let response = app.post_login(&body).await;

    // Assert
    assert_eq!(303, response.status().as_u16());
    assert_is_redirect_to(&response, "/login");

    // Act - Part 2 - Follow the redirect
    let html_page = app.get_login_html().await;
    println!("HTML_PAGE: {:?}", html_page);
    assert!(html_page.contains("<div>Authentication failed<div>"));

    // Act - Part 3 - Reload the login page
    let html_page = app.get_login_html().await;
    assert!(!html_page.contains("Authentication failed"));
}

#[actix_web::test]
async fn login_is_a_success() {
    let app = spawn_app().await;

    let login_body = serde_json::json!({
        "username": &app.test_user.username,
        "password": &app.test_user.password
    });

    let response = app.post_login(&login_body).await;

    assert_eq!(303, response.status().as_u16());
    assert_is_redirect_to(&response, "/");
}

