CREATE TABLE IF NOT EXISTS executions
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    trade_id BIGSERIAL references trades (id) ON DELETE CASCADE,
    instrument_id SERIAL references instruments (id),
    account_id SERIAL references accounts (id),
    fill_time TIMESTAMPTZ NOT NULL,
    order_id TEXT NOT NULL,
    commissions REAL,
    price REAL NOT NULL,
    quantity INTEGER NOT NULL,
    is_buy BOOLEAN NOT NULL, -- TRUE for 'buy', FALSE for 'sell'
    is_initial_entry BOOLEAN NOT NULL,
    is_last_exit BOOLEAN NOT NULL,
    is_entry BOOLEAN NOT NULL,
    is_exit BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
