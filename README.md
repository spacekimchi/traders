# Traders

## Setting up the project

### Rust

The recommended way of [installing Rust](https://www.rust-lang.org/tools/install) is through rustup

`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

### PostgreSQL

The project is using [PostgreSQL](https://www.postgresql.org/). You can install PostgreSQL for whatever machine you are using.

There is a docker script for starting a PostgreSQL database.

Use this command to connect to the PostgreSQL docker container.

`psql -h 127.0.0.1 -p 5432 -U postgres`

### Redis

[Redis](https://github.com/redis/redis) is required for some features like keeping user sessions.
You can also install Redis for whatever machine you are using.

### sqlx

I use [sqlx-cli](https://github.com/launchbadge/sqlx/tree/main/sqlx-cli) to manage the database. The following command will install for only postgres

`cargo install sqlx-cli --no-default-features --features native-tls,postgres`

## When deploying to server

Remember to get a copy of the `configuration/local.yaml`, `configuration/base.yaml`, and `configuration/production.yaml`.

`base_url` needs to be set in the `configuration/production.yaml`. This can be set to the domain the project
will be hosted on.

Create a systemd service to run the application.

## TODO
- [x] Bring database changes from other repository and get at least homepage to show
- [x] Set up server to display homepage
- [x] Set up CI/CD
  - [x] Set up a `master` branch for production and a `development` branch for development. Work off of `development` branch
  - [x] Set up so `master` branch deploys to server whenever it is pushed to
- [x] Set up separate repository with a minimal production ready app with user login and a homepage
- [ ] Fix the test suite
  - [ ] Routes:
    - [x] HealthCheck
    - [x] Users
  - [ ] Models:
    - [ ] Users
  - [ ] Domain:
    - [ ] Username
    - [ ] Email
- [ ] Implement remainder of routes (Write tests simultaneously and remove all hardcoded strings)
  - [ ] User
  - [ ] Account
  - [ ] Trade
  - [ ] Execution
  - [ ] JournalEntry
  - [ ] Tag
- [ ] Look into some best practice for database management
  - [ ] Make a cron job to do nightly pg_dumps for database backups and upload to some cloud server

## Frontend

Instead of using a frontend framework, this project will use SSR to serve HTML, SCSS, and JavaScript.

The templating engine used here is the [handlebars-rust](https://github.com/sunng87/handlebars-rust) crate.

TODO:
  [] Add Stimulus/Turbo with Hotwire

## Current State

I am currently working to stabilize the development experience and infrastructure.

The plan to achieve this is:
1. ~~Get the app in a minimal working state (have health_check and homepage showing)~~
2. Set up CI/CD, and then write tests.
  - Start with tests for applicaiton setup files, health_check endpoint, and users endpoints
    - There is a lot of outdated code in the users routes. (the file also needs to be renamed to `src/routes/users`
    - Write documentaiton along the way
4. Copy this point of the project to a new repository
  - This will make starting a new project with actix-web a breeze as there will be a great starting point

## Testing

If an error like this appears `failed to find data for query INSERT INTO users (id, email, username, password_hash)`
 - run this command `DATABASE_URL=postgres://your_database_url cargo sqlx prepare`

## Purpose

NinjaTrader is a futures trading platform that provides users with an excel file (.xlsx) of every trade execution they make during that trading day.

This project provides a way for futures traders to easily keep track of all their trades and provide visual feedback of how much money they are losing.

Excel file uploads are watched using the `./traders-watch.sh` script, which are then parsed into trades using the `./trademaker` executable.

These trades are saved using a PostgreSQL database and served through an API using the [Actix Web](https://github.com/actix/actix-web "Actix Web") web framework.

