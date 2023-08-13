CREATE TABLE IF NOT EXISTS trades_tags
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    trade_id BIGSERIAL REFERENCES trades (id) ON DELETE CASCADE,
    tag_id BIGSERIAL REFERENCES tags (id) ON DELETE CASCADE,
    UNIQUE (trade_id, tag_id)
);