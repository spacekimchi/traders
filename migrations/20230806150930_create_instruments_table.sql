CREATE TABLE IF NOT EXISTS instruments
(
    id SERIAL NOT NULL PRIMARY KEY,
    code TEXT NOT NULL UNIQUE, -- E.g., 'ES', 'NQ', etc.
    price_per_point NUMERIC(10, 2) NOT NULL,
    description TEXT
);
