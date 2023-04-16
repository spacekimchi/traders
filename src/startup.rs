use crate::routes::{user, trade, health_check, account, login, journal_entry};
use actix_web::{App, web, HttpServer, http::Method};
use tracing_actix_web::TracingLogger;
use actix_web::dev::Server;
use sqlx::{Pool, PgPool, Postgres};
use std::net::TcpListener;
use sqlx::postgres::PgPoolOptions;
use crate::configuration::Settings;
use crate::configuration::DatabaseSettings;
use actix_session::SessionMiddleware;
use actix_session::storage::RedisSessionStore;
use secrecy::{Secret, ExposeSecret};
use actix_web::cookie::Key;
use actix_web_lab::middleware::from_fn;
use crate::authentication::reject_anonymous_users;

pub struct AppState {
    pub db: Pool<Postgres>,
    pub hmac_secret: Secret<String>,
}

pub struct Application {
    port: u16,
    server: Server,
}

impl Application {
    pub async fn build(configuration: Settings) -> Result<Self, anyhow::Error> {
        let connection_pool = get_connection_pool(&configuration.database);

        let address = format!(
            "{}:{}",
            configuration.application.host, configuration.application.port
        );
        let listener = TcpListener::bind(address)?;
        let port = listener.local_addr().unwrap().port();
        let server = run(
            connection_pool,
            listener,
            configuration.application.base_url,
            configuration.redis_uri,
            configuration.application.hmac_secret,
        ).await?;

        Ok(Self { port, server })
    }

    pub fn port(&self) -> u16 {
        self.port
    }

    pub async fn run_until_stopped(self) -> Result<(), std::io::Error> {
        self.server.await
    }
}

pub fn get_connection_pool(
    configuration: &DatabaseSettings
) -> PgPool {
    PgPoolOptions::new()
        .max_connections(5)
        .connect_lazy_with(configuration.with_db())
}

pub struct ApplicationBaseUrl(pub String);

pub async fn run(db_pool: PgPool, listener: TcpListener, base_url: String, redis_uri: Secret<String>, hmac_secret: Secret<String>) -> Result<Server, anyhow::Error> {
    let base_url = web::Data::new(ApplicationBaseUrl(base_url));
    let redis_store = RedisSessionStore::new(redis_uri.expose_secret()).await?;
    let secret_key = Key::from(hmac_secret.expose_secret().as_bytes());
    let server = HttpServer::new(move || {
        App::new().service(
            web::scope("/api")
            .wrap(TracingLogger::default())
            .wrap(SessionMiddleware::new(redis_store.clone(), secret_key.clone()))
            .app_data(web::Data::new(AppState { db: db_pool.clone(), hmac_secret: hmac_secret.clone() }))
            .app_data(base_url.clone())
            .service(health_check::health_check)
            .service(login::login)
            .service(login::logout)
            .service(user::create)
            .service(user::current_user)
            .service(user::get)
            .service(user::list)
            .service(user::delete)
            .service(user::change_password)
            .service(
                web::scope("/trades")
                .wrap(from_fn(reject_anonymous_users))
                .service(trade::list)
                .service(trade::index)
                .service(trade::delete)
                .service(trade::import_trade)
            )
            .service(
                web::scope("/journal_entries")
                .wrap(from_fn(reject_anonymous_users))
                .service(journal_entry::list)
                .service(journal_entry::index)
                .service(journal_entry::delete)
                .service(journal_entry::create)
            )
            //.service(trade::create)
            .service(account::list)
            .default_service(web::route().method(Method::GET)))
        })
        .listen(listener)?
        .run();
    
    Ok(server)
}

