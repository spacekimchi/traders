CREATE TABLE IF NOT EXISTS executions
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    account_id SERIAL NOT NULL references accounts (id),
    trade_id BIGINT references trades (id) ON DELETE CASCADE,
    instrument_id SERIAL NOT NULL references instruments (id),
    order_id TEXT NOT NULL,
    fill_time TIMESTAMPTZ NOT NULL,
    commission REAL NOT NULL,
    price REAL NOT NULL,
    quantity INTEGER NOT NULL,
    is_entry BOOLEAN NOT NULL,
    is_exit BOOLEAN NOT NULL,
    is_buy BOOLEAN NOT NULL, -- TRUE for 'buy', FALSE for 'sell'
    execution_id TEXT NOT NULL UNIQUE, -- This is the execution_id from the NinjaTrader
    position INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
