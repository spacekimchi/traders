CREATE TABLE IF NOT EXISTS roles
(
    id SERIAL NOT NULL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

INSERT INTO roles (name) VALUES ('demo'), ('user'), ('admin'), ('super_admin')
ON CONFLICT (name) DO NOTHING;
