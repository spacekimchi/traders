CREATE TABLE IF NOT EXISTS tags
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id uuid REFERENCES users (id) ON DELETE CASCADE,
    name TEXT NOT NULL
);

CREATE UNIQUE INDEX idx_tags_user_name ON tags (user_id, name);
