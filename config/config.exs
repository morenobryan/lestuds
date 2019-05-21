# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :study_manager,
  ecto_repos: [StudyManager.Repo]

# Configures the endpoint
config :study_manager, StudyManagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hvuQJYPxR39qidqDnP6FhmurG0FMDWCVz4S4JQdys3npgKHZ32ulgYVyM/8Nff2Z",
  render_errors: [view: StudyManagerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StudyManager.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Überauth authentication strategies
config :ueberauth, Ueberauth,
  providers: [
    identity: {
      Ueberauth.Strategy.Identity,
      [callback_methods: ["POST"], param_nesting: "user"]
    }
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
