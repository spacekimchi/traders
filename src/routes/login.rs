use actix_web::http::header::LOCATION;
use crate::authentication::{validate_credentials, Credentials};
use actix_web::{HttpResponse, post};
use actix_web::web::{Data, Json};
use secrecy::Secret;
use crate::startup::AppState;
use crate::authentication::AuthError;
use crate::routes::user::error_chain_fmt;
use actix_web::http::StatusCode;
use actix_web::ResponseError;

#[derive(serde::Deserialize, Debug)]
pub struct LoginForm {
    username: String,
    password: Secret<String>,
}

#[tracing::instrument(
    skip(form, state),
    fields(username=tracing::field::Empty, id=tracing::field::Empty)
)]
#[post("/login")]
pub async fn login(form: Json<LoginForm>, state: Data<AppState>) -> Result<HttpResponse, LoginError> {
    let credentials = Credentials {
        username: form.username.to_string(),
        password: form.password.clone(),
    };
    tracing::Span::current()
        .record("username", &tracing::field::display(&credentials.username));
    let user_id = validate_credentials(credentials, &state)
        .await
        .map_err(|e| match e {
            AuthError::InvalidCredentials(_) => LoginError::AuthError(e.into()),
            AuthError::UnexpectedError(_) => LoginError::UnexpectedError(e.into()),
        })?;
    tracing::Span::current().record("user_id", &tracing::field::display(&user_id));
    Ok(HttpResponse::SeeOther()
        .insert_header((LOCATION, "/"))
        .finish())
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

impl ResponseError for LoginError {
    fn error_response(&self) -> HttpResponse {
        /* TODO
         * Replace this with a json error response
         */
        HttpResponse::build(self.status_code())
            .insert_header((LOCATION, "/login"))
            .finish()
    }

    fn status_code(&self) -> StatusCode {
        match self {
            LoginError::UnexpectedError(_) => StatusCode::INTERNAL_SERVER_ERROR,
            LoginError::AuthError(_) => StatusCode::UNAUTHORIZED,
        }
    }
}