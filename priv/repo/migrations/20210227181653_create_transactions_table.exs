defmodule Rocketpay.Repo.Migrations.CreateTransactionsTable do
  use Ecto.Migration

  def change do
    create table :transactions do
      add :from_id, references(:users, type: :binary_id)
      add :to_id, references(:users, type: :binary_id)
      add :value, :decimal

      timestamps()
    end

    create constraint(:transactions, :value_must_be_positive, check: "value >= 1")
  end
end
