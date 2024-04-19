ALTER TABLE journal_entries
ADD CONSTRAINT unique_user_entry_date UNIQUE (user_id, entry_date);
