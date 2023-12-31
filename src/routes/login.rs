use actix_web::http::header::LOCATION;
use actix_web::web::{Data, Form};
use actix_web::error::InternalError;
use actix_web::{HttpResponse, post, get};
use actix_web_flash_messages::{FlashMessage, IncomingFlashMessages};
use secrecy::Secret;

use crate::errors;
use crate::session_state::TypedSession;
use crate::template_helpers::{RenderTemplateParams, render_content};
use crate::utils::{e500, error_chain_fmt};
use crate::startup::AppState;
use crate::authentication::AuthError;
use crate::authentication::{validate_credentials, Credentials};

#[derive(thiserror::Error)]
pub enum LoginError {
    #[error("Authentication failed")]
    AuthError(#[source] anyhow::Error),
    #[error("Something went wrong")]
    UnexpectedError(#[from] anyhow::Error),
    #[error(transparent)]
    Error(#[from] actix_web::Error),
}

impl actix_web::ResponseError for LoginError {
    fn error_response(&self) -> HttpResponse {
        let error_message = format!("{}", self);
        let error_response = errors::ApiError { message: error_message };

        match self {
            LoginError::AuthError(_) => HttpResponse::BadRequest().json(error_response),
            LoginError::UnexpectedError(_) => HttpResponse::Unauthorized().json(error_response),
            LoginError::Error(_) => HttpResponse::InternalServerError().json(error_response),
        }
    }
}

impl std::fmt::Debug for LoginError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

#[derive(serde::Deserialize, Debug)]
pub struct LoginForm {
    username: String,
    password: Secret<String>,
}

/// This route is for displaying the login page
#[get("/login")]
async fn get_login_page(tera_store: Data<tera::Tera>, flash_messages: IncomingFlashMessages) -> Result<HttpResponse, LoginError> {
    let context = tera::Context::new();

    let content = render_content(&RenderTemplateParams::new(&"login.html", &tera_store)
                                         .with_flash_messages(&flash_messages)
                                         .with_context(&context))?;

    Ok(HttpResponse::Ok().content_type("text/html").body(content))
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
                FlashMessage::info("Login success!").send();
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
        return Ok(HttpResponse::Unauthorized().body("you are unauthorized"));
    }
    session.logout();
    Ok(HttpResponse::SeeOther()
       .insert_header((LOCATION, "/"))
       .finish())
}

fn login_redirect(e: LoginError) -> InternalError<LoginError> {
    FlashMessage::error(e.to_string()).send();
    let response = HttpResponse::SeeOther()
        .insert_header((LOCATION, "/login"))
        .finish();
    InternalError::from_response(e, response)
}
