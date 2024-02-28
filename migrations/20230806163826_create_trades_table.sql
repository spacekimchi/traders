CREATE TABLE IF NOT EXISTS trades
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id uuid REFERENCES users (id) ON DELETE CASCADE,
    account_id BIGSERIAL REFERENCES accounts (id) ON DELETE CASCADE,
    instrument_id SERIAL REFERENCES instruments (id),
    entry_time TIMESTAMPTZ NOT NULL,
    exit_time TIMESTAMPTZ NOT NULL,
    commission REAL,
    pnl REAL,
    is_long BOOLEAN,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_trades_account_id_entry_exit_time
ON trades(account_id, entry_time, exit_time);
