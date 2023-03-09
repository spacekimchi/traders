use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Json, Path};
use actix_web::{HttpResponse, Responder, get, post, delete};
//use actix_web::web::Path;

use sqlx::{self, FromRow};
//use crate::response::Response;
use crate::startup::AppState;

//pub type Users = Response<User>;

use tracing::Instrument;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct User {
    pub id: uuid::Uuid,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    pub username: String,
    pub email: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct UserRequest {
    pub username: String,
    pub email: String,
}

#[get("/users")]
pub async fn list(state: Data<AppState>) -> impl Responder {
    // TODO: get users this will have query params "?ingredients=apple,chicken,thyme"
    println!("[users.rs:list]");
    match sqlx::query_as::<_, User>("SELECT id, username, email, created_at FROM users")
        .fetch_all(&state.db)
        .await
        {
            Ok(users) => HttpResponse::Ok().content_type("application/json").json(users),
            Err(_) => HttpResponse::NotFound().json("No users found"),
        }
}

#[post("/users")]
pub async fn create(state: Data<AppState>, body: Json<UserRequest>) -> HttpResponse {
    /* Need to remove request_id logic and possible pass it in as a parameter? */
    let request_id = uuid::Uuid::new_v4();
    let user_id = uuid::Uuid::new_v4();

    /* tracing */
    let request_span = tracing::info_span!(
        "Adding a new subscriber",
        %request_id,
        %user_id,
        user_email = %body.email,
        user_name = %body.username
    );
    /* tracing::info!("request_id {} - Creating new user '{}' '{}' and saving to database", request_id, body.email, body.username); */
    /* tracing::info_span! replaces the above to give context and span to the request data */
    /* do not use .enter() in async functions */
    let _request_span_guard = request_span.enter();

    let query_span = tracing::info_span!(
        "Saving new subscriber details in the database"
    );

    let created_at = chrono::offset::Utc::now();
    match sqlx::query_as::<_, User>(
        "INSERT INTO users (id, username, email, created_at) VALUES ($1, $2, $3, $4) RETURNING id, username, email, visible, created_at, updated_at"
    )
    .bind(user_id)
    .bind(&body.username)
    .bind(&body.email)
    .bind(created_at)
    .fetch_one(&state.db)
    .instrument(query_span)
    .await
    {
        Ok(user) => {
            tracing::info!("request_id {} - New user has been saved", request_id);
            HttpResponse::Ok().json(user)
        },
        Err(err) => {
            tracing::error!("request_id {} - Failed to save user to database with error: {:?}", request_id, err); /* use {:?} here for more debug info */
            HttpResponse::InternalServerError().json(format!("Failed to create user: {err}"))
        },
    }
}

#[get("/users/{user_id}")]
pub async fn get(state: Data<AppState>, path: Path<String>) -> impl Responder {
    // TODO: Get user by ID. This will discard query params
    let user_id = path.into_inner();
    match sqlx::query_as::<_, User>("SELECT id, username, email, created_at FROM users WHERE id = $1")
        .bind(user_id)
        .fetch_all(&state.db)
        .await
        {
            Ok(user) => HttpResponse::Ok().json(user),
            Err(_) => HttpResponse::NotFound().json("No user found"),
        }
}

#[delete("/users/{user_id}")]
pub async fn delete(_state: Data<AppState>, _path: Path<(String,)>) -> HttpResponse {
    // TODO: Delete user by ID
    // in any case return status 204

    HttpResponse::NoContent()
        .content_type("application/json")
        .await
        .unwrap()
}

