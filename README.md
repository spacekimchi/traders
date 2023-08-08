# Traders

## Purpose

NinjaTrader is a futures trading platform that provides users with an excel file (.xlsx) of every trade execution they make during that trading day.
This project provides a way for futures traders to easily keep track of all their trades and provide visual feedback for what works and doesn't work to save them money in the long run.
Excel file uploads are watched using the `./traders-watch.sh` script, which are then parsed into trades using the `./trademaker` executable.
These trades are saved using a PostgreSQL database and served through an API using the [Actix Web](https://github.com/actix/actix-web "Actix Web") web framework.

Traders using the NinjaTrader platform, feel free to sign up for an account at [www.tradebetter.io](https://www.tradebetter.io).

