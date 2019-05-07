defmodule BankLambda.Repo.Migrations.AddAttributesToPayments do
  use Ecto.Migration

  def change do
    alter table(:payments) do
      add(:user_id, references(:users))

      add(:end_to_end_id, :string)
      add(:remittance_information_unstructured, :string)
      add(:instructed_amount, :integer)
      add(:instructed_currency, :string)
      add(:debtor_iban, :string)
      add(:creditor_iban, :string)
      add(:creditor_name, :string)
    end
  end
end
