use crate::routes::{user, trade, health_check};
use actix_web::{App, web, HttpServer};
use tracing_actix_web::TracingLogger;
use actix_web::dev::Server;
use actix_web::cookie::Key;
use sqlx::{Pool, Postgres};
use std::net::TcpListener;

pub struct AppState {
    pub db: Pool<Postgres>,
}

pub fn run(db_pool: Pool<Postgres>, _secret_key: Key, listener: TcpListener) -> Result<Server, std::io::Error> {
    let server = HttpServer::new(move || {
        App::new()
            .wrap(TracingLogger::default())
            .app_data(web::Data::new(AppState { db: db_pool.clone() }))
            .service(health_check::health_check)
            .service(user::create)
            .service(user::get)
            .service(user::list)
            .service(user::delete)
            .service(trade::create)
            .service(trade::get)
            .service(trade::list)
            .service(trade::delete)
        })
        .listen(listener)?
        .run();
    
    Ok(server)
}

