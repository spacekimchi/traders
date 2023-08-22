use actix_web::http::header::LOCATION;
use actix_web::{web::{Data, Form}, HttpResponse, HttpRequest, get, post};
use actix_web_flash_messages::{FlashMessage, IncomingFlashMessages};

use crate::startup::AppState;
use crate::errors::UserError;
use crate::db::models::users::{UserForm, save_user_to_database};
use crate::template_helpers::{render_content, RenderTemplateParams, err_500_template};

#[tracing::instrument(
    name = "New user page",
    skip(tera_engine, flash_messages),
)]
#[get("/new")]
pub async fn new_user_page(tera_engine: Data<tera::Tera>, flash_messages: IncomingFlashMessages) -> HttpResponse {
    match render_content(&RenderTemplateParams::new("users/new", &tera_engine).with_flash_messages(&flash_messages)) {
        Ok(new_user_page_template) => HttpResponse::Ok().body(new_user_page_template),
        Err(e) => HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e))
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
pub async fn create_user(
    state: Data<AppState>,
    body: Form<UserForm>,
    request: HttpRequest,
    tera_engine: Data<tera::Tera>
) -> Result<HttpResponse, UserError> {
    save_user_to_database(&state, &body).await?;
    FlashMessage::success("User creation successful!").send();
    Ok(HttpResponse::SeeOther().insert_header((LOCATION, "/")).finish())
}

