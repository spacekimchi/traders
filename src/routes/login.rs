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
use crate::session_state::TypedSession;
use crate::utils::e500;

#[derive(serde::Deserialize, Debug)]
pub struct LoginForm {
    username: String,
    password: Secret<String>,
}

#[tracing::instrument(
    skip(form, state, session),
    fields(username=tracing::field::Empty, id=tracing::field::Empty)
)]
#[post("/login")]
pub async fn login(form: Json<LoginForm>, state: Data<AppState>, session: TypedSession) -> Result<HttpResponse, LoginError> {
    let credentials = Credentials {
        username: form.username.to_string(),
        password: form.password.clone(),
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
                    .map_err(|e| LoginError::UnexpectedError(e.into()))?;
                // Set cookies with: 
                // Ok(HttpResponse::Ok().cookie(Cookie::new("_flash", e.to_string)).json(user_id))
                // unset cookies with: add_removal_cookie() method
                // let mut response = HttpResponse::Ok()
                //      .content_type(ContentType::html())
                //      .body(/* */);
                //  response
                //      .add_removal_cookie(&Cookie::new("_flash", ""))
                //      .unwrap();
                //  response
                //
                Ok(HttpResponse::Ok().json(user_id))
            }
            Err(e) => {
                match e {
                    AuthError::InvalidCredentials(_) => Err(LoginError::AuthError(e.into())),
                    AuthError::UnexpectedError(_) => Err(LoginError::UnexpectedError(e.into())),
                }
            }
        }
}

#[post("/login")]
pub async fn logout(session: TypedSession) -> Result<HttpResponse, actix_web::Error> {
    if session.get_user_id().map_err(e500)?.is_none() {
        return Ok(HttpResponse::Unauthorized().json("you are unauthorized"));
    }
    session.logout();
    Ok(HttpResponse::Ok().finish())
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
         * it currently just redirects to /login
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
