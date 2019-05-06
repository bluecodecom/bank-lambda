# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bank_lambda,
  ecto_repos: [BankLambda.Repo]

# Configures the endpoint
config :bank_lambda, BankLambdaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZxTs8Z2AhaHGFP6xjIRPB85ZOozB/84oTEMj0WJZyf+q/vH6EYbqNLkUILiVCjyD",
  render_errors: [view: BankLambdaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BankLambda.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix_oauth2_provider, PhoenixOauth2Provider,
  module: BankLambda,
  router: BankLambda.Router,
  current_resource_owner: :current_user,
  repo: BankLambda.Repo,
  resource_owner: BankLambda.Accounts.User

import_config "#{Mix.env()}.exs"
