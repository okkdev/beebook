# Beebook
## Setup Postgres development DB

  * Install natively and create database with user `postgres` and password `postgres`

  or

  * Get docker image with `docker pull postgres`
  * Start image with `docker run --name beebook -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres`


## Start the Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install && cd ..`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4001`](http://localhost:4001) from your browser. (allow self signed https certs for this site)

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
