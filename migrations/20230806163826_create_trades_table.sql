CREATE TABLE IF NOT EXISTS trades
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id uuid REFERENCES users (id) ON DELETE CASCADE,
    account_id BIGSERIAL REFERENCES accounts (id) ON DELETE CASCADE,
    ticker TEXT NOT NULL,
    entry_time DOUBLE PRECISION NOT NULL,
    exit_time DOUBLE PRECISION NOT NULL,
    commission REAL NOT NULL,
    pnl REAL NOT NULL DEFAULT 0.0,
    is_long BOOLEAN NOT NULL,
    is_open BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_trades_account_id_entry_exit_time
ON trades(account_id, entry_time, exit_time);
