CREATE TABLE IF NOT EXISTS trades
(
    id SERIAL NOT NULL PRIMARY KEY,
    user_id INTEGER REFERENCES users (id),
    shared BOOLEAN DEFAULT TRUE,
	instrument TEXT,
	action TEXT,
	quantity INTEGER,
	price NUMERIC(10,2),
	time SMALLINT,
	entry BOOLEAN,
	position TEXT,
	commission NUMERIC(8,2),
	rate INTEGER,
	account_display_name TEXT,
	pnl NUMERIC(12,2),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
