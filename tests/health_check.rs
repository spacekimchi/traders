//! tests/health_check.rs
use sqlx::{PgConnection, Executor, Connection};
use traders::configuration::{get_configuration, DatabaseSettings};
use traders::telemetry::{get_subscriber, init_subscriber};
use traders::startup::run;
use sqlx::{postgres::PgPoolOptions, Pool, Postgres};
use actix_web::cookie::Key;
use once_cell::sync::Lazy;
use secrecy::ExposeSecret;

static TRACING: Lazy<()> = Lazy::new(|| {
    let default_filter_level = "info".to_string();
    let subscriber_name = "test".to_string();
    if std::env::var("TEST_LOG").is_ok() {
        let subscriber = get_subscriber(subscriber_name, default_filter_level, std::io::stdout);
        init_subscriber(subscriber);
    } else {
        let subscriber = get_subscriber(subscriber_name, default_filter_level, std::io::sink);
        init_subscriber(subscriber);
    };
});

pub struct TestApp {
    pub address: String,
    pub db_pool: Pool<Postgres>,
}

#[actix_web::test]
async fn health_check_works() {
    let address = spawn_app().await;
    let client = reqwest::Client::new();
    let response = client
        .get(&format!("{}/health_check", &address.address))
        .send()
        .await
        .expect("Failed to execute request.");

    assert!(response.status().is_success());
    assert_eq!(Some(0), response.content_length());
}

async fn spawn_app() -> TestApp {
    /*
     * The first time 'initialize is invoked the code in 'TRACING' is executed.
     * All other invocations will instead skip execution (so init_subscriber() is only called once)
     */
    Lazy::force(&TRACING);

    let listener = std::net::TcpListener::bind("127.0.0.1:0")
        .expect("Failed to bind to random port");
    let port = listener.local_addr().unwrap().port();
    let mut configuration = get_configuration().expect("Failed to read configuration");
    configuration.database.database_name = uuid::Uuid::new_v4().to_string();
    /* Session */
    let secret_key = Key::from(configuration.test.secret_key.as_bytes());
    let db_pool = configure_database(&configuration.database).await;
    let server = run(db_pool.clone(), secret_key, listener).expect("failed to bind address");
    let address = format!("http://127.0.0.1:{}", port);
    let _ = actix_web::rt::spawn(server);
    TestApp {
        address,
        db_pool
    }
}

pub async fn configure_database(config: &DatabaseSettings) -> Pool<Postgres> {
    /* Create database to use for testing */
    let mut connection = PgConnection::connect(config.connection_string_without_db().expose_secret())
        .await
        .expect("Failed to connect to Postgres");
    connection
        .execute(format!(r#"CREATE DATABASE "{}";"#, config.database_name).as_str())
        .await
        .expect("Failed to create database.");

    let connection_pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(config.connection_string_without_db().expose_secret())
        .await
        .expect("Error building a conneciton pool");
    sqlx::migrate!("./migrations")
        .run(&connection_pool)
        .await
        .expect("failed to migrate the database");

    connection_pool
}

