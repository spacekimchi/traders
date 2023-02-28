//! tests/health_check.rs

#[actix_web::test]
async fn health_check_works() {
    let address = spawn_app();

    let client = reqwest::Client::new();

    let response = client
        .get(&format!("{}/health_check", &address))
        .send()
        .await
        .expect("Failed to execute request.");

    assert!(response.status().is_success());
    assert_eq!(Some(0), response.content_length());
}

fn spawn_app() -> String {
    let address = "127.0.0.1:0";
    let listener = std::net::TcpListener::bind("127.0.0.1:0")
        .expect("Failed to bind to random port");
    let port = listener.local_addr().unwrap().port();
    let server = traders::run(db_pool, secret_key, listener).expect("failed to bind address");

    let _ = actix_web::rt::spawn(server);
    format!("http://127.0.0.1:{}", port)
}
