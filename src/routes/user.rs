use serde::{Deserialize, Serialize};
use actix_web::web::{Data, Json, Path};
use actix_web::{HttpResponse, Responder, get, post, delete};
use sqlx::{self, FromRow};
use crate::startup::AppState;

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
    match sqlx::query_as::<_, User>("SELECT id, username, email, created_at FROM users")
        .fetch_all(&state.db)
        .await
        {
            Ok(users) => HttpResponse::Ok().content_type("application/json").json(users),
            Err(_) => HttpResponse::NotFound().json("No users found"),
        }
}

#[tracing::instrument(
    name = "Creating a new user",
    skip(state, body),
    fields(
        email = %body.email,
        username = %body.username,
    )
)]
#[post("/users")]
pub async fn create(state: Data<AppState>, body: Json<UserRequest>) -> HttpResponse {
    match insert_user(&state, &body)
        .await
        {
            Ok(user) => {
                HttpResponse::Ok().json(user)
            },
            Err(err) => {
                tracing::error!("Failed to save user to database with error: {:?}", err); /* use {:?} here for more debug info */
                HttpResponse::InternalServerError().json(format!("Failed to create user: {err}"))
            },
        }
}

#[tracing::instrument(
    name = "Saving new user in the database",
    skip(state, body),
)]
pub async fn insert_user(state: &Data<AppState>, body: &Json<UserRequest>) -> Result<User, sqlx::Error> {
    let user_id = uuid::Uuid::new_v4();
    let created_at = chrono::offset::Utc::now();
    sqlx::query_as::<_, User>(
        "INSERT INTO users (id, username, email, created_at) VALUES ($1, $2, $3, $4) RETURNING id, username, email, visible, created_at, updated_at"
    )
    .bind(user_id)
    .bind(&body.username)
    .bind(&body.email)
    .bind(created_at)
    .fetch_one(&state.db)
    .await
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

