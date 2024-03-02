use serde::Serialize;

/**
 * For retruning consistent JSON errors
 */
#[derive(Debug, Serialize)]
pub struct ApiError {
    pub message: String,
}
