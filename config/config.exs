# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tumentor,
  ecto_repos: [Tumentor.Repo]

# Configures the endpoint
config :tumentor, TumentorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RTAUWEDritZuThMfa5UjFxpNU2V/SB93z1R2VfQtE1Hh4xXV+HgzDT2HjJ7Cwg39",
  render_errors: [view: TumentorWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tumentor.PubSub,
  live_view: [signing_salt: "xKjY8IJ8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
