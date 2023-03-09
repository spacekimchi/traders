use traders::startup::run;
use traders::configuration::get_configuration;
use traders::telemetry::{get_subscriber, init_subscriber};
use dotenv::dotenv;
use actix_web::cookie::Key;
use sqlx::postgres::PgPoolOptions;
use secrecy::ExposeSecret;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let subscriber = get_subscriber("traders".into(), "info".into(), std::io::stdout);
    init_subscriber(subscriber);

    /* a way for application to ignore errors from loading .env instead of failing */
    dotenv().ok();
    
    let configuration = get_configuration().expect("Failed to read configuration");
    /* DATABASE://DATABASE_USER:DATABASE_PASSWORD@DATABASE_HOST:DATABASE_PORT/DATABASE_DB_NAME */

    let cookie_k = std::env::var("COOKIE_K").expect("COOKIE_K must be set");

    /* Session */
    let secret_key = Key::from(cookie_k.as_bytes());

    //let _address = "127.0.0.1:8000";
    let address = format!("127.0.0.1:{}", configuration.application_port);

    /* Listener */
    let listener = std::net::TcpListener::bind(address)?;

    let db_pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(configuration.database.connection_string().expose_secret())
        .await
        .expect("Error building a conneciton pool");

    run(db_pool, secret_key, listener)?.await
}
