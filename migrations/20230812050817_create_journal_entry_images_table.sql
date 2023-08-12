CREATE TABLE IF NOT EXISTS journal_entry_images
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    journal_entry_id BIGINT REFERENCES journal_entries(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
