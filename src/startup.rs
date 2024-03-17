use std::net::TcpListener;

use actix_web::{App, web, HttpServer, http::Method};
use actix_web::dev::Server;
use actix_session::SessionMiddleware;
use actix_session::storage::RedisSessionStore;
use actix_web::cookie::Key;
use actix_web_lab::middleware::from_fn;
use actix_web_flash_messages::storage::CookieMessageStore;
use actix_web_flash_messages::FlashMessagesFramework;
use tracing_actix_web::TracingLogger;
// use sqlx::{Pool, Postgres};
// Pool<Postgres> is similar to PgPool
// PgPool is sqlx's version
use sqlx::PgPool;
use sqlx::postgres::PgPoolOptions;
use secrecy::{Secret, ExposeSecret};

use crate::configuration::Settings;
use crate::configuration::DatabaseSettings;
use crate::authentication::reject_anonymous_users;
use crate::routes::{users, login, homepage, trade_routes, execution_routes, journal_entry_routes};
use crate::routes::api;
use crate::template_helpers;

pub struct AppState {
    pub db: PgPool,
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
    let message_store = CookieMessageStore::builder(secret_key.clone()).build();
    let message_framework = FlashMessagesFramework::builder(message_store).build();
    // Create a Tera instance
    let mut tera = match tera::Tera::new("./static/templates/**/*html") {
        Ok(t) => t,
        Err(e) => {
            // Handle error appropriately (e.g., panic or log the error)
            panic!("Parsing error(s): {}", e);
        },
    };
    // Register the custom filter
    tera.register_filter("currency_format", template_helpers::currency_format);
    // Wrap the Tera instance in web::Data for Actix-web
    let tera = web::Data::new(tera);

    let server = HttpServer::new(move || {
        App::new()
            .wrap(TracingLogger::default())
            .wrap(message_framework.clone())
            .wrap(SessionMiddleware::new(
                    redis_store.clone(),
                    secret_key.clone())
                )
            .app_data(base_url.clone())
            .app_data(web::Data::new(AppState {
                db: db_pool.clone(),
                hmac_secret: hmac_secret.clone()
            }))

            .app_data(tera.clone())
            .service(actix_files::Files::new(
                    "/static",
                    "./static/"
                    ))
            .service(homepage::index)
            .service(login::get_login_page)
            .service(login::login)
            .service(login::logout)
            .service(execution_routes::get_executions_index)
            .service(
                web::scope("/trades")
                .service(trade_routes::get_trades_index)
                .service(trade_routes::process_trades)
            )
            .service(
                web::scope("/users")
                .wrap(from_fn(reject_anonymous_users))
                .service(users::new_user_page)
                .service(users::create_user)
            )
            .service(
                web::scope("/journal_entries")
                .service(journal_entry_routes::get_journal_entries_index)
            )
            .service(
                web::scope("/api")
                .service(api::health_check::health_check)
                .service(api::health_check::health_check_post)
                .service(api::execution_routes::ninja_trader_executions_import)
                .service(api::accounts::list)
                .service(api::users::current_user)
                .service(
                    web::scope("/users")
                    .wrap(from_fn(reject_anonymous_users))
                    .service(api::users::list_users)
                    .service(api::users::delete)
                    .service(api::users::create_user)
                    .service(api::users::change_user_password)
                    .service(api::users::get_user_by_id)
                )
                .default_service(web::route().method(Method::GET)))
        })
        .listen(listener)?
        .run();
    
    Ok(server)
}

