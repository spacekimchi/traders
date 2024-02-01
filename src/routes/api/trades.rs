use actix_web::{HttpResponse, Responder, get, delete, post};
use actix_web::web::{Data, Path, Query};
use actix_multipart::Multipart;
use serde::{Deserialize, Serialize};
use sqlx::{self, FromRow, postgres::PgArguments, Arguments};

use crate::db::models::trades::{get_trades, TradeQuery};
use crate::session_state::TypedSession;
use crate::startup::AppState;
use crate::utils::e500;

#[derive(Debug, Deserialize, Serialize, FromRow)]
pub struct Trade {
    pub id: i64,
    pub account_id: i64,
	pub instrument: String,
    pub entry_time: f64,
    pub exit_time: f64,
	pub commission: f32,
    pub pnl: f32,
    pub short: bool,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TradeRequest {
    pub instrument: Vec<String>,
	pub entry_time: Vec<f64>,
	pub exit_time: Vec<f64>,
	pub commission: Vec<f32>,
	pub pnl: Vec<f32>,
	pub short: Vec<bool>,
}

impl std::fmt::Display for TradeRequest {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(
            f,
            "TradeFields: {:?}",
            self.instrument,
        )
    }
}

#[tracing::instrument(
    name = "[route.trades:index]",
    skip(state, _session, tq),
)]
#[get("")]
pub async fn index(state: Data<AppState>, _session: TypedSession, tq: Query<TradeQuery>) -> Result<impl Responder, actix_web::Error> {
    /* fill the "" below in with today's date */
    let trades = get_trades(&state, &tq).await.map_err(e500)?;
    Ok(HttpResponse::Ok().content_type("application/json").json(trades))
}

#[delete("/{trade_id}")]
pub async fn delete(_state: Data<AppState>, _path: Path<(String,)>) -> HttpResponse {
    // TODO: Delete trade by ID
    // in any case return status 204

    HttpResponse::NoContent()
        .content_type("application/json")
        .await
        .unwrap()
}

#[post("/import")]
pub async fn import_trade(payload: Multipart, session: TypedSession) -> Result<HttpResponse, actix_web::Error> {
    let user_id = match session
        .get_user_id()
        .map_err(e500)? {
            Some(user_id) => user_id,
            None => return Ok(HttpResponse::Unauthorized().json("You are not authorized"))
        };
    let upload_status = files::save_file(payload, "/data/incoming".to_string(), user_id).await;

    match upload_status {
        Some(true) => {
            Ok(HttpResponse::Ok()
               .content_type("text/plain")
               .body("update_succeeded"))
        }
        _ => Ok(HttpResponse::BadRequest()
                .content_type("text/plain")
                .body("update_failed")),
    }
}

pub struct GetTradesError(sqlx::Error);

impl std::fmt::Display for GetTradesError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "A database failure was encountered while trying to get trades."
        )
    }
}

pub mod files {
    use std::io::Write;
    use actix_multipart::Multipart;
    use actix_web::web;
    use futures::{StreamExt, TryStreamExt};

    pub async fn save_file(mut payload: Multipart, file_path: String, user_id: uuid::Uuid) -> Option<bool> {
        // iterate over multipart stream
        while let Ok(Some(mut field)) = payload.try_next().await {
            let filename = match field.content_disposition().get_filename() {
                Some(filename) => filename.replace(' ', "_").to_string(),
                None => return None
            };

            let user_path = format!(".{}/{}", file_path, user_id);
            let filepath = format!("{}/{}", user_path, filename);
            // File::create is blocking operation, use threadpool
            let mut f = web::block(move || {
                    std::fs::create_dir_all(user_path)?;
                    std::fs::File::create(filepath)
                })
                .await
                .unwrap();

            // Field in turn is stream of *Bytes* object
            while let Some(chunk) = field.next().await {
                let data = chunk.unwrap();
                // filesystem operations are blocking, we have to use threadpool
                f = web::block(move || f.as_ref().expect("file write error").write_all(&data).map(|_| f))
                    .await
                    .unwrap().unwrap();
            }
        }

        Some(true)
    }
}
