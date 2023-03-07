use crate::routes::{user, trade, health_check};

use actix_web::{middleware, App, web, HttpServer, HttpResponse, Error};
use actix_web::dev::Server;

use actix_session::{Session, SessionMiddleware, storage::RedisActorSessionStore};
use actix_web::cookie::Key;

use sqlx::{Pool, Postgres};
use std::net::TcpListener;

use actix_web::middleware::Logger;

pub struct AppState {
    pub db: Pool<Postgres>,
}
//mod seeds;

pub fn run(db_pool: Pool<Postgres>, secret_key: Key, listener: TcpListener) -> Result<Server, std::io::Error> {
    let server = HttpServer::new(move || {
        App::new()
            .wrap(Logger::default())
            .wrap(
                SessionMiddleware::new(
                    RedisActorSessionStore::new("127.0.0.1:6379"),
                    secret_key.clone()
                    )
                )
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

