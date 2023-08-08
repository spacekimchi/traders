# Traders

## TODO
- [ ] DOCUMENTATION FOR ALL OF THESE TODOS IS A MUST
- [ ] Fix the test suite
  - [ ] Routes:
    - [ ] HealthCheck
    - [ ] Users
  - [ ] Models:
    - [ ] Users
  - [ ] Domain:
    - [ ] Username
    - [ ] Email
- [ ] Bring database changes from other repository and get at least homepage to show
- [ ] Set up server to display homepage
- [ ] Set up CI/CD
  - [ ] Set up a `master` branch for production and a `stage` branch for staging. Work off of `stage` branch
  - [ ] Set up so `master` branch deploys to server whenever it is pushed to
- [ ] Implement remainder of routes (Write tests simultaneously)
  - [ ] User
  - [ ] Account
  - [ ] Trade
  - [ ] Execution
  - [ ] JournalEntry
  - [ ] Tag
- [ ] Look into some best practice for database management
  - [ ] Make a cron job for a nightly pg_dump for daily backups

## Current State

I am currently working to stabilize the development experience and infrastructure.

## Purpose

NinjaTrader is a futures trading platform that provides users with an excel file (.xlsx) of every trade execution they make during that trading day.

This project provides a way for futures traders to easily keep track of all their trades and provide visual feedback of how much money they are losing.

Excel file uploads are watched using the `./traders-watch.sh` script, which are then parsed into trades using the `./trademaker` executable.

These trades are saved using a PostgreSQL database and served through an API using the [Actix Web](https://github.com/actix/actix-web "Actix Web") web framework.

