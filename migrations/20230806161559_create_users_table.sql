CREATE TABLE IF NOT EXISTS users
(
    id uuid NOT NULL PRIMARY KEY,
    username TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    role_id INTEGER REFERENCES roles(id),
    visible BOOLEAN DEFAULT TRUE,
    ninja_trader_id TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
