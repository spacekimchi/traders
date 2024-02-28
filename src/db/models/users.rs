use actix_web::web::{Data, Form};
use serde::{Deserialize, Serialize};
use sqlx::{self, FromRow};
use secrecy::{Secret, ExposeSecret};
use anyhow::Context;

use crate::errors::*;
use crate::startup::AppState;
use crate::authentication::compute_password_hash;
use crate::telemetry::spawn_blocking_with_tracing;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct User {
    pub id: uuid::Uuid,
    pub visible: bool,
    pub username: String,
    pub password_hash: String,
    pub email: String,
    pub ninja_trader_id: String,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

#[derive(Debug, Deserialize)]
pub struct UserForm {
    pub username: String,
    pub email: String,
    pub password: Secret<String>,
}

#[tracing::instrument(name = "Get username", skip(state))]
pub async fn get_username(
    user_id: uuid::Uuid, 
    state: &Data<AppState>,
) -> Result<String, anyhow::Error> {
    let row = sqlx::query!(
        r#"
        SELECT username
        FROM users
        WHERE id = $1
        "#,
        user_id,
    ) .fetch_one(&state.db)
    .await
    .context("Failed to perform a query to retrieve a username.")?;
    Ok(row.username)
}

/// This will get all the users from the database.
/// Only a superadmin should ever be able to view this route
#[tracing::instrument(
    name = "Grabbing users from the database",
    skip(state),
)]
pub async fn get_users_from_database(state: &Data<AppState>) -> Result<Vec<User>, UserError> {
    sqlx::query_as::<_, User>("SELECT id, username, email, visible, created_at, updated_at FROM users")
        .fetch_all(&state.db)
        .await
        .map_err(UserError::DatabaseError)
}

/// Gets a user by id from the database
pub async fn get_user_from_database(state: &Data<AppState>, user_id: &String) -> Result<User, UserError> {
    // TODO: Get user by ID. This will discard query params
    sqlx::query_as::<_, User>("SELECT id, username, email, created_at FROM users WHERE id = $1")
        .bind(user_id)
        .fetch_one(&state.db)
        .await
        .map_err(UserError::DatabaseError)
}

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct UserId {
    pub id: uuid::Uuid,
}

/// Gets a user by ninja_trader_id from the database
pub async fn get_user_from_database_by_ninja_trader_id(state: &Data<AppState>, ninja_trader_id: &String) -> Result<UserId, UserError> {
    sqlx::query_as::<_, UserId>("SELECT id FROM users WHERE ninja_trader_id = $1")
        .bind(ninja_trader_id)
        .fetch_one(&state.db)
        .await
        .map_err(UserError::DatabaseError)
}

/// Saves a new user into the database
#[tracing::instrument(
    name = "Saving new user in the database",
    skip(state, body),
)]
pub async fn save_user_to_database(state: &Data<AppState>, body: &Form<UserForm>) -> Result<User, StoreUserError> {
    let user_id = uuid::Uuid::new_v4();
    let password = body.0.password.clone();

    /* TODO: Study this pattern */
    let password_hash_result = spawn_blocking_with_tracing(move || compute_password_hash(password)).await;
    let password_hash = match password_hash_result {
        Ok(hash) => hash,
        Err(_) => return Err(StoreUserError(anyhow::anyhow!("Failed to hash password"))),
    };
    let exposed_s = password_hash?.expose_secret().to_string();

    sqlx::query_as::<_, User>(
        "INSERT INTO users (id, username, email, password_hash) VALUES ($1, $2, $3, $4) RETURNING id, username, email, visible, password_hash, created_at, updated_at"
    )
    .bind(user_id)
    .bind(&body.0.username)
    .bind(&body.0.email)
    .bind(exposed_s)
    .fetch_one(&state.db)
    .await
    .map_err(|err| StoreUserError(err.into()))
}

