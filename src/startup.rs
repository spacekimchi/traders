use std::net::TcpListener;

use actix_web::{App, web, HttpServer, http::Method};
use actix_web::dev::Server;
use actix_session::SessionMiddleware;
use actix_session::storage::RedisSessionStore;
use actix_web::cookie::Key;
use actix_web_lab::middleware::from_fn;
use tracing_actix_web::TracingLogger;
use sqlx::{Pool, PgPool, Postgres};
use sqlx::postgres::PgPoolOptions;
use secrecy::{Secret, ExposeSecret};
use handlebars::Handlebars;

use crate::configuration::Settings;
use crate::configuration::DatabaseSettings;
use crate::authentication::reject_anonymous_users;
use crate::routes::{users, trades, health_check, accounts, login, journal_entries, homepage};

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
    let mut handlebars = Handlebars::new();

    handlebars
        .register_templates_directory(".html", "./static/templates")
        .unwrap();

    let handlebars_ref = web::Data::new(handlebars);

    let server = HttpServer::new(move || {
        App::new()
            .wrap(TracingLogger::default())
            .wrap(SessionMiddleware::new(redis_store.clone(), secret_key.clone()))
            .app_data(base_url.clone())
            .app_data(web::Data::new(AppState { db: db_pool.clone(), hmac_secret: hmac_secret.clone() }))
            .app_data(handlebars_ref.clone())
            .service(homepage::index)
            .service(
                web::scope("/api")
                .service(health_check::health_check)
                .service(users::current_user)
                .service(login::login)
                .service(login::logout)
                .service(accounts::list)
                .service(
                    web::scope("")
                    .wrap(from_fn(reject_anonymous_users))
                    .service(users::list_users)
                    .service(users::delete)
                    .service(users::change_user_password)
                    .service(users::create_user)
                    .service(users::get_user_by_id)
                )
                .service(
                    web::scope("/trades")
                    .service(trades::index)
                    .service(
                        web::scope("")
                        .wrap(from_fn(reject_anonymous_users))
                        .service(trades::delete)
                        .service(trades::import_trade)
                    ) 
                )
                .service(
                    web::scope("/journal_entries")
                    .service(journal_entries::index)
                    .service(
                        web::scope("")
                        .wrap(from_fn(reject_anonymous_users))
                        .service(journal_entries::delete)
                        .service(journal_entries::create)
                    ) 
                )
                .default_service(web::route().method(Method::GET)))
        })
        .listen(listener)?
        .run();
    
    Ok(server)
}

