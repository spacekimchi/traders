use std::fmt::Write;

use actix_web::http::header::LOCATION;
use actix_web::web::{Data, Form};
use actix_web::error::InternalError;
use actix_web::{HttpResponse, post, get};
use actix_web_flash_messages::{FlashMessage, IncomingFlashMessages};
use handlebars::Handlebars;
use serde_json::json;
use secrecy::Secret;

use crate::utils::{e500, error_chain_fmt};
use crate::startup::AppState;
use crate::authentication::AuthError;
use crate::session_state::TypedSession;
use crate::authentication::{validate_credentials, Credentials};

#[derive(serde::Deserialize, Debug)]
pub struct LoginForm {
    username: String,
    password: Secret<String>,
}

/// This route is for displaying the login page
///
#[get("/login")]
async fn get_login_page(hb: Data<Handlebars<'_>>, flash_messages: IncomingFlashMessages) -> HttpResponse {
    let mut error_html = String::new();
    for m in flash_messages.iter() {
        writeln!(error_html, "<p><i>{}</i></p>", m.content()).unwrap();
    }

    // Since we want to display that error_html as a raw html,
    // we can use {{{error_html}}} in the html file
    let data = json!({
        "error_html": error_html,
    });
    let body = hb.render("login", &data).unwrap();
    HttpResponse::Ok().body(body)
}

#[tracing::instrument(
    skip(form, state, session),
    fields(username=tracing::field::Empty, id=tracing::field::Empty)
)]
#[post("/login")]
pub async fn login(form: Form<LoginForm>, state: Data<AppState>, session: TypedSession) -> Result<HttpResponse, InternalError<LoginError>> {
    let credentials = Credentials {
        username: form.0.username,
        password: form.0.password,
    };
    tracing::Span::current()
        .record("username", &tracing::field::display(&credentials.username));
    match validate_credentials(credentials, &state)
        .await
        {
            Ok(user_id) => {
                tracing::Span::current().record("user_id", &tracing::field::display(&user_id));
                session.renew();
                session
                    .insert_user_id(user_id)
                    .map_err(|e| login_redirect(LoginError::UnexpectedError(e.into())))?;
                Ok(HttpResponse::SeeOther()
                   .insert_header((LOCATION, "/"))
                   .finish())
            }
            Err(e) => {
                let e = match e {
                    AuthError::InvalidCredentials(_) => LoginError::AuthError(e.into()),
                    AuthError::UnexpectedError(_) => LoginError::UnexpectedError(e.into()),
                };
                Err(login_redirect(e))
            }
        }
}

#[post("/logout")]
pub async fn logout(session: TypedSession) -> Result<HttpResponse, actix_web::Error> {
    if session.get_user_id().map_err(e500)?.is_none() {
        return Ok(HttpResponse::Unauthorized().json("you are unauthorized"));
    }
    session.logout();
    Ok(HttpResponse::Ok().finish())
}

fn login_redirect(e: LoginError) -> InternalError<LoginError> {
    FlashMessage::error(e.to_string()).send();
    let response = HttpResponse::SeeOther()
        .insert_header((LOCATION, "/api/login"))
        .finish();
    InternalError::from_response(e, response)
}

#[derive(thiserror::Error)]
pub enum LoginError {
    #[error("Authentication failed")]
    AuthError(#[source] anyhow::Error),
    #[error("Something went wrong")]
    UnexpectedError(#[from] anyhow::Error),
}

impl std::fmt::Debug for LoginError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

