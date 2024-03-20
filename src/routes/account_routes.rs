//! src/routes/account_routes.rs
//!
//! This file should contain routes related to executions for html endpoints
//!

use actix_web::web::Data;
use actix_web::{HttpResponse, Responder, get};

use crate::startup::AppState;
use crate::session_state::TypedSession;
use crate::template_helpers::{render_content, RenderTemplateParams, err_500_template};
use crate::utils::e500;
use crate::db::models;
use crate::errors::account_errors;

#[tracing::instrument(name = "Get Executions Index", skip(tera_engine, state, session))]
#[get("")]
async fn get_accounts_index(tera_engine: Data<tera::Tera>, session: TypedSession, state: Data<AppState>) -> Result<impl Responder, actix_web::Error> {
    let user_id = match session
        .get_user_id()
        .map_err(e500)? {
            Some(user_id) => user_id,
            // This None will grab the default user_id, which is my account
            None => models::users::get_user_from_database_by_ninja_trader_id(&state.db, &"YourNinjaTraderIdString".to_string()).await?.id
        };
    let accounts = models::accounts::fetch_accounts_by_user_id_for_index_table(&state.db, &user_id)
        .await
        .map_err(|err| account_errors::AccountError::DatabaseError(err))?;

    let mut context = tera::Context::new();
    context.insert("accounts", &accounts);
    match render_content(&RenderTemplateParams::new("accounts/index.html", &tera_engine)
                         .with_context(&context)
                         .with_session(&session)) {
        Ok(executions_template) => Ok(HttpResponse::Ok().body(executions_template)),
        Err(e) => Ok(HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e)))
    }
}
