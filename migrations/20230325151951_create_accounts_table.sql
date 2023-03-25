CREATE TABLE IF NOT EXISTS accounts
(
	id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id uuid REFERENCES users (id) ON DELETE CASCADE,
	name TEXT NOT NULL,
	pub BOOLEAN DEFAULT TRUE
);
