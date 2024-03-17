CREATE TABLE IF NOT EXISTS trade_processing_status_messages
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    trade_processing_status_id BIGSERIAL REFERENCES trade_processing_statuses(id) ON DELETE CASCADE,
    user_id uuid REFERENCES users (id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
