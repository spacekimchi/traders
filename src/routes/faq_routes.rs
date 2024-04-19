//! src/routes/faq_routes.rs
//!
//! This file is used to create a route for the faq
//! The faq_routes template can be found in static/templates/faq/index.html

use actix_web::{get, HttpResponse, web};
use actix_web::web::Data;
use actix_web_flash_messages::IncomingFlashMessages;

use crate::template_helpers::{RenderTemplateParams, render_content};
use crate::startup::AppState;
use crate::session_state::TypedSession;
use crate::utils;

/// This route is for getting the FAQ page.
#[get("/faq")]
async fn index(tera_engine: web::Data<tera::Tera>, flash_messages: IncomingFlashMessages, session: TypedSession, state: Data<AppState>) -> Result<HttpResponse, actix_web::Error> {
    let _user_id = match session
        .get_user_id()
        .map_err(utils::e500)? {
            Some(user_id) => user_id,
            // This None will grab the default user_id, which is my account
            None => crate::db::models::users::get_user_from_database_by_ninja_trader_id(&state.db, &"YourNinjaTraderIdString".to_string()).await?.id
        };

    let mut context = tera::Context::new();
    context.insert("google_image_to_markdown_faq_anchor", utils::faq_anchors::GOOGLE_IMAGE_TO_MARKDOWN);
    let content = render_content(&RenderTemplateParams::new(&"faq/index.html", &tera_engine)
                                         .with_flash_messages(&flash_messages)
                                         .with_context(&context)
                                         .with_session(&session))?;

    Ok(HttpResponse::Ok().content_type("text/html").body(content))
}

