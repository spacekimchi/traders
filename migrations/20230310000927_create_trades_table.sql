CREATE TABLE IF NOT EXISTS trades
(
    id SERIAL NOT NULL PRIMARY KEY,
    user_id uuid REFERENCES users (id),
	instrument TEXT NOT NULL,
	action TEXT NOT NULL,
	quantity INTEGER NOT NULL,
	price NUMERIC(10,2) NOT NULL,
	day INTEGER NOT NULL,
	time DOUBLE PRECISION NOT NULL,
	commission NUMERIC(8,2),
	account_display_name TEXT NOT NULL,
	pnl NUMERIC(8,2),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
