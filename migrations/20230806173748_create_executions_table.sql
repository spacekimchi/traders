CREATE TABLE IF NOT EXISTS executions
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    account_id SERIAL references accounts (id),
    trade_id BIGSERIAL references trades (id) ON DELETE CASCADE,
    order_id TEXT NOT NULL,
    instrument_id SERIAL references instruments (id),
    fill_time TIMESTAMPTZ NOT NULL,
    commission REAL,
    price REAL NOT NULL,
    quantity INTEGER NOT NULL,
    is_buy BOOLEAN NOT NULL, -- TRUE for 'buy', FALSE for 'sell'
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
