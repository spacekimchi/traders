use crate::routes::{user, trade, health_check, account};
use actix_web::{App, web, HttpServer, middleware, http::Method};
use tracing_actix_web::TracingLogger;
use actix_web::dev::Server;
use sqlx::{Pool, PgPool, Postgres};
use std::net::TcpListener;
use sqlx::postgres::PgPoolOptions;
use actix_cors::Cors;
use crate::configuration::Settings;
use crate::configuration::DatabaseSettings;

pub struct AppState {
    pub db: Pool<Postgres>,
}

pub struct Application {
    port: u16,
    server: Server,
}

impl Application {
    pub async fn build(configuration: Settings) -> Result<Self, std::io::Error> {
        let connection_pool = get_connection_pool(&configuration.database);

        let address = format!(
            "{}:{}",
            configuration.application.host, configuration.application.port
        );
        let listener = TcpListener::bind(address)?;
        let port = listener.local_addr().unwrap().port();
        let server = run(connection_pool, listener, configuration.application.base_url)?;

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

pub fn run(db_pool: PgPool, listener: TcpListener, base_url: String) -> Result<Server, std::io::Error> {
    let base_url = web::Data::new(ApplicationBaseUrl(base_url));
    let server = HttpServer::new(move || {
        let cors = Cors::default()
            .allowed_origin("http://localhost:3000");
        App::new()
            .wrap(TracingLogger::default())
            .wrap(middleware::NormalizePath::default())
            .wrap(cors)
            .app_data(web::Data::new(AppState { db: db_pool.clone() }))
            .app_data(base_url.clone())
            .service(health_check::health_check)
            .service(user::create)
            .service(user::get)
            .service(user::list)
            .service(user::delete)
            //.service(trade::create)
            .service(trade::list)
            .service(trade::index)
            .service(trade::delete)
            .service(account::list)
            .default_service(web::route().method(Method::GET))
        })
        .listen(listener)?
        .run();
    
    Ok(server)
}

