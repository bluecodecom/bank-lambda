defmodule BankLambda.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :integer

    timestamps()
  end

  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
