# Beebook

To start the Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start dev database with `docker run --name beebook -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install && cd ..`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
