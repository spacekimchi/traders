use actix_web::web::{Data, Path};
use actix_web::{HttpResponse, HttpRequest, Responder, get};
use sqlx::{self};
use crate::startup::AppState;
use crate::db::models::accounts;

#[tracing::instrument(
    name = "List accounts",
    skip(state),
)]
#[get("/accounts")]
pub async fn list(state: Data<AppState>, request: HttpRequest) -> impl Responder {
    //let query_string = request.query_string();
    match get_accounts(&state, &request)
        .await
        {
            Ok(accounts) => HttpResponse::Ok().content_type("application/json").json(accounts),
            Err(err) => HttpResponse::NotFound().json(format!("Error: {err}")),
        }
}

#[tracing::instrument(
    name = "Grabbing accounts from the database",
    skip(state),
)]
pub async fn get_accounts(state: &Data<AppState>, request: &HttpRequest) -> Result<Vec<accounts::Account>, sqlx::Error> {
    let _query_string = request.query_string();
    sqlx::query_as::<_, accounts::Account>("SELECT id, user_id, name, visible, sim, created_at, updated_at FROM accounts")
        .fetch_all(&state.db)
        .await
}

#[tracing::instrument(
    name = "List account by id",
    skip(state),
)]
#[get("/accounts/{account_id}")]
pub async fn get(state: Data<AppState>, path: Path<u32>, request: HttpRequest) -> impl Responder {
    let _account_id = path.into_inner();
    match get_accounts(&state, &request)
        .await
        {
            Ok(accounts) => HttpResponse::Ok().content_type("application/json").json(accounts),
            Err(err) => HttpResponse::NotFound().json(format!("Error: {err}")),
        }
}
