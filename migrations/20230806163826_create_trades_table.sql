CREATE TABLE IF NOT EXISTS trades
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    account_id BIGSERIAL REFERENCES accounts (id) ON DELETE CASCADE,
    instrument_id SERIAL REFERENCES instruments (id),
    entry_time DOUBLE PRECISION NOT NULL,
    exit_time DOUBLE PRECISION NOT NULL,
    commissions REAL,
    pnl REAL,
    is_short BOOLEAN,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
