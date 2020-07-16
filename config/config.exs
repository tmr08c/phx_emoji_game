# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phx_emoji_game,
  ecto_repos: [PhxEmojiGame.Repo]

# Configures the endpoint
config :phx_emoji_game, PhxEmojiGameWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FqE1+nbNDoNKJK6YN0q2DU05WXZFsykGS2BASFvApEhE1tV9+sBcJK8d8DWPX75y",
  render_errors: [view: PhxEmojiGameWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhxEmojiGame.PubSub,
  live_view: [signing_salt: "vmYqegrE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
