# Traders

## TODO
- [ ] DOCUMENTATION FOR ALL OF THESE TODOS IS A MUST
- [x] Bring database changes from other repository and get at least homepage to show
- [x] Set up server to display homepage
- [ ] Set up CI/CD
  - [ ] Set up a `master` branch for production and a `stage` branch for staging. Work off of `stage` branch
  - [ ] Set up so `master` branch deploys to server whenever it is pushed to
- [ ] Fix the test suite
  - [ ] Routes:
    - [x] HealthCheck
    - [ ] Users
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

This project will use HTML, SCSS, and JavaScript.

The templating engine used here is the [handlebars-rust](https://github.com/sunng87/handlebars-rust) crate

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

