defmodule BankLambda.Repo do
  use Ecto.Repo,
    otp_app: :bank_lambda,
    adapter: Ecto.Adapters.Postgres
end
