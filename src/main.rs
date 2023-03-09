use traders::startup::run;
use traders::configuration::get_configuration;
use actix_web::cookie::Key;

use sqlx::{postgres::PgPoolOptions, Pool, Postgres};
use dotenv::dotenv;
use std::{env, io};

use tracing::subscriber::set_global_default;
use tracing_bunyan_formatter::{BunyanFormattingLayer, JsonStorageLayer};
use tracing_subscriber::{layer::SubscriberExt, EnvFilter, Registry};

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    /*
     * env::set_var("RUST_LOG", "actix_web=debug,actix_server=info");
     * env_logger::init();
     * The bottom lines replace the two above
     */
    let env_filter = EnvFilter::try_from_default_env()
        .unwrap_or_else(|_| EnvFilter::new("info"));
    let formatting_layer = BunyanFormattingLayer::new(
        "traders".into(),
        /* Output the formatted spans to stdout. */
        std::io::stdout
    );

    /*
     * The 'with' method is provided by 'SubscriberExt', an extension
     * trait for 'Subscriber' exposed by 'tracing_subscriber'
     */
    let subscriber = Registry::default()
        .with(env_filter)
        .with(JsonStorageLayer)
        .with(formatting_layer);

    /*
     * 'set_global_default' can be used by applications to specify
     * what subscriber should be used to process spans.
     */
    set_global_default(subscriber).expect("Failed to set subscriber");

    dotenv().ok();
    println!("Connecting to database: {}", std::env::var("DATABASE_URL").unwrap());
    
    let configuration = get_configuration().expect("Failed to read configuration");
    /* DATABASE://DATABASE_USER:DATABASE_PASSWORD@DATABASE_HOST:DATABASE_PORT/DATABASE_DB_NAME */
    let _database = std::env::var("DATABASE").expect("DATABSE must be set");
    let _database_user = std::env::var("DATABASE_USER").expect("DATABASE_USER must be set");
    let _database_password = std::env::var("DATABASE_PASSWORD").expect("DATABASE_PASSWORD must be set");
    let _database_host = std::env::var("DATABASE_HOST").expect("DATABASE_HOST must be set");
    let _database_port = std::env::var("DATABASE_PORT").expect("DATABASE_PORT must be set");
    let _database_name = std::env::var("DATABASE_NAME").expect("DATABSE_NAME must be set");
    let database_url = std::env::var("DATABASE_URL").expect("DATABSE_URL must be set");
    println!("database_url: {}", database_url);
    let cookie_k = std::env::var("COOKIE_K").expect("COOKIE_K must be set");


    /* Session */
    let secret_key = Key::from(cookie_k.as_bytes());

    //let _address = "127.0.0.1:8000";
    let address = format!("127.0.0.1:{}", configuration.application_port);
    println!("configuration.application_port: {}", configuration.application_port);

    /* Listener */
    let listener = std::net::TcpListener::bind(address)?;

    let db_pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await
        .expect("Error building a conneciton pool");

    println!("i am here");
    run(db_pool, secret_key, listener)?.await
}
