//! src/routes/journal_entries/mod.rs
//!
//! This file is for all the routes contained under the traders.jinz.co/journal_entries url.

use actix_web::{web::Data, HttpResponse, get};
use uuid::Uuid;

use crate::db::models::journal_entries;
use crate::session_state::TypedSession;
use crate::startup::AppState;

#[get("")]
pub async fn get_journal_entries_root(state: Data<AppState>, session: TypedSession, tera_engine: Data<tera::Tera>) -> HttpResponse {
    let user_id = match session.get_user_id() {
        Ok(user_id) => user_id,
        Err(e) => return HttpResponse::Unauthorized().body("You are unauthorized")
    };




    return HttpResponse::Ok().body("");
}
