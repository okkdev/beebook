# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :beebook,
  ecto_repos: [Beebook.Repo]

# Configures the endpoint
config :beebook, BeebookWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0JF1lJ6Fy+MZSvx1QlPTVUHv8IBVZZ1+Pq/fzZ7hVm/iMhHZgQPiFCJxcE3EF+d+",
  render_errors: [view: BeebookWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Beebook.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Liveview templating language support
config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
