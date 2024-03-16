CREATE TABLE IF NOT EXISTS trade_processing_statuses
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id uuid REFERENCES users (id) ON DELETE CASCADE,
    processing_status TEXT NOT NULL, -- STARTED, SUCCESS, FAILED
    attempted_execution_ids BIGINT[],
    failed_execution_ids BIGINT[],
    started_processing_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
