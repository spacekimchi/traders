use traders::run;
use actix_web::cookie::Key;

use sqlx::{postgres::PgPoolOptions, Pool, Postgres};
use dotenv::dotenv;
use std::{env, io};

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    env::set_var("RUST_LOG", "actix_web=debug,actix_server=info");
    env_logger::init();

    dotenv().ok();
    println!("Connecting to database: {}", std::env::var("DATABASE_URL").unwrap());
    /* DATABASE://DATABASE_USER:DATABASE_PASSWORD@DATABASE_HOST:DATABASE_PORT/DATABASE_DB_NAME */
    let _database = std::env::var("DATABASE").expect("DATABSE must be set");
    let _database_user = std::env::var("DATABASE_USER").expect("DATABASE_USER must be set");
    let _database_password = std::env::var("DATABASE_PASSWORD").expect("DATABASE_PASSWORD must be set");
    let _database_host = std::env::var("DATABASE_HOST").expect("DATABASE_HOST must be set");
    let _database_port = std::env::var("DATABASE_PORT").expect("DATABASE_PORT must be set");
    let _database_name = std::env::var("DATABASE_NAME").expect("DATABSE_NAME must be set");
    let database_url = std::env::var("DATABASE_URL").expect("DATABSE_URL must be set");
    let cookie_k = std::env::var("COOKIE_K").expect("COOKIE_K must be set");


    /* Session */
    let secret_key = Key::from(cookie_k.as_bytes());

    /* Listener */
    let listener = std::net::TcpListener::bind("127.0.0.1:8000").expect("failed to bind to port");

    let _address = "127.0.0.1:8000";

    let db_pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await
        .expect("Error building a conneciton pool");

    run(db_pool, secret_key, listener)?.await
}
