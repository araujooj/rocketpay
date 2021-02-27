defmodule Rocketpay.Transactions do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rocketpay.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:value, :from_id, :to_id]

  schema "transactions" do
    field :value, :decimal

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:value, name: :balance_must_be_positive)
  end
end
