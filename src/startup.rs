use crate::routes::{user, trade, health_check, account};
use actix_web::{App, web, HttpServer, middleware, http::Method};
use tracing_actix_web::TracingLogger;
use actix_web::dev::Server;
use actix_web::cookie::Key;
use sqlx::{Pool, Postgres};
use std::net::TcpListener;
use actix_cors::Cors;

pub struct AppState {
    pub db: Pool<Postgres>,
}

pub fn run(db_pool: Pool<Postgres>, _secret_key: Key, listener: TcpListener) -> Result<Server, std::io::Error> {
    let server = HttpServer::new(move || {
        let cors = Cors::default()
            .allowed_origin("http://localhost:3000");
        App::new()
            .wrap(TracingLogger::default())
            .wrap(middleware::NormalizePath::default())
            .wrap(cors)
            .app_data(web::Data::new(AppState { db: db_pool.clone() }))
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

