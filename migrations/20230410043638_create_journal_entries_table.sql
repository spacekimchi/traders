CREATE TABLE IF NOT EXISTS journal_entries
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id uuid REFERENCES users (id) ON DELETE CASCADE,
	entry_date INTEGER NOT NULL UNIQUE,
	image_urls TEXT[],
	notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
