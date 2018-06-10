# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :magirator_app_gui, MagiratorAppGuiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "23c+ICZlSkNMJDiabdVfDSzOprkIN36fGrqlRywqmrVAErFyu4R4gB3wDOHjMo8X",
  render_errors: [view: MagiratorAppGuiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MagiratorAppGui.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
