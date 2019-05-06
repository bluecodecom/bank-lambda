defmodule BankLambda.Payments.Payment do
  use Ecto.Schema

  schema "payments" do
    field :amount, :integer

    timestamps()
  end
end
