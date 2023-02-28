CREATE TABLE IF NOT EXISTS trades
(
    id SERIAL NOT NULL PRIMARY KEY,
    user_id INTEGER REFERENCES users (id),
	broker TEXT NOT NULL,
	instrument TEXT NOT NULL,
	action TEXT NOT NULL,
	quantity INTEGER NOT NULL,
	price NUMERIC(10,2) NOT NULL,
	day INTEGER NOT NULL,
	time INTEGER NOT NULL,
	entry BOOLEAN NOT NULL,
	position TEXT,
	commission NUMERIC(8,2),
	account_display_name TEXT NOT NULL,
	pnl NUMERIC(10,2),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
