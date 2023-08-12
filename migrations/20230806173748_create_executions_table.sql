CREATE TABLE IF NOT EXISTS executions
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    trade_id BIGSERIAL references trades (id) ON DELETE CASCADE,
    instrument_id SERIAL references instruments (id),
    fill_time DOUBLE PRECISION NOT NULL,
    commissions REAL,
    price REAL NOT NULL,
    is_buy BOOLEAN NOT NULL, -- TRUE for 'buy', FALSE for 'sell'
    quantity INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
