use crate::helpers::spawn_app;

#[actix_web::test]
async fn invalid_user_is_unable_to_login() {
    let app = spawn_app().await;
    let body = serde_json::json!({
            "username": "test_user1",
            "password": "password",
        });
    
    let response = app.post_login(&body).await;

    // Assert
    assert_eq!(401, response.status().as_u16());
}

#[actix_web::test]
async fn login_is_a_success() {
    let app = spawn_app().await;

    let login_body = serde_json::json!({
        "username": &app.test_user.username,
        "password": &app.test_user.password
    });

    let response = app.post_login(&login_body).await;

    assert_eq!(200, response.status().as_u16());
    // Act - Part 2 - Follow the redirect
    //let html_page = app.get_admin_dashboard().await;
    //assert!(html_page.contains(&format!("Welcome {}", app.test_user.username)));
}

/*
use reqwest::header::HeaderValue;
use std::collections::HashSet;

// testing that cookies set properly
//
#[tokio::test]
async fn an_error_flash_message_is_set_on_failure() {
    // [...]
    let flash_cookie = response.cookies().find(|c| c.name() == "_flash").unwrap();
    assert_eq!(flash_cookie.value(), "Authentication failed");
}
*/
