defmodule BankLambda.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field(:amount, :integer)
    # belongs_to(:user_id, references(:users))

    field(:end_to_end_id, :string)
    field(:remittance_information_unstructured, :string)
    field(:instructed_amount, :integer)
    field(:instructed_currency, :string)
    field(:debtor_iban, :string)
    field(:creditor_iban, :string)
    field(:creditor_name, :string)

    timestamps()
  end

  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [
      :amount,
      :end_to_end_id,
      :remittance_information_unstructured,
      :instructed_amount,
      :instructed_currency,
      :debtor_iban,
      :creditor_iban,
      :creditor_name
    ])
  end
end
