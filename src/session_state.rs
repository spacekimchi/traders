//! src/session_state.rs
//! This file is a wrapper to actix_session::Session
use std::future::{Ready, ready};

use actix_session::{Session, SessionGetError, SessionInsertError, SessionExt};
use actix_web::dev::Payload;
use actix_web::{FromRequest, HttpRequest};
use uuid::Uuid;

/// wrapper on Session
pub struct TypedSession(Session);

/// TypedSession
/// storing key "user_id" as the current user's session
impl TypedSession {
    const USER_ID_KEY: &'static str = "user_id";

    pub fn renew(&self) {
        self.0.renew();
    }

    pub fn logout(&self) {
        self.0.purge()
    }

    pub fn insert_user_id(&self, user_id: Uuid) -> Result<(), SessionInsertError> {
        self.0.insert(Self::USER_ID_KEY, user_id)
    }

    pub fn get_user_id(&self) -> Result<Option<Uuid>, SessionGetError> {
        self.0.get(Self::USER_ID_KEY)
    }
}

impl FromRequest for TypedSession {
    // This is a complicated way of saying 
    // "We return the same error returned by the 
    // implementation of `FromRequest` for `Session`".
    type Error = <Session as FromRequest>::Error;
    // Rust does not yet support the `async` syntax in traits.
    // From request expects a `Future` as return type to allow for extractors
    // that need to perform asynchronous operations (e.g. a HTTP call)
    // We do not have a `Future`, because we don't perform any I/O,
    // so we wrap `TypedSession` into `Ready` to convert it into a `Future` that
    // resolves to the wrapped value the first time it's polled by the executor.
    type Future = Ready<Result<TypedSession, Self::Error>>;

    fn from_request(req: &HttpRequest, _payload: &mut Payload) -> Self::Future {
        ready(Ok(TypedSession(req.get_session())))
    }
}
