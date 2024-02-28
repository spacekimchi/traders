use sqlx::{PgPool, FromRow};
use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize, FromRow)]
pub struct Instrument {
    pub id: i32,
    pub code: String,
    pub price_per_tick: f32,
    pub description: String,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub created_at: chrono::DateTime<chrono::offset::Utc>,
    #[serde(with = "chrono::serde::ts_seconds")]
    pub updated_at: chrono::DateTime<chrono::offset::Utc>,
}

pub async fn fetch_instruments(db_pool: &PgPool) -> Result<Vec<Instrument>, sqlx::Error> {
    let instruments = sqlx::query_as!(Instrument, "SELECT * FROM instruments")
        .fetch_all(db_pool)
        .await?;
    Ok(instruments)
}
