CREATE TABLE IF NOT EXISTS instruments
(
    id SERIAL NOT NULL PRIMARY KEY,
    code TEXT NOT NULL UNIQUE, -- E.g., 'ES', 'NQ', etc.
    price_per_tick REAL NOT NULL,
    description TEXT NOT NULL DEFAULT 'instrument',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
