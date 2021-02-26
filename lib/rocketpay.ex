defmodule Rocketpay do
  alias Rocketpay.Account.{Deposit, Withdraw, Transaction}

  alias Rocketpay.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call

  defdelegate withdraw(params), to: Withdraw, as: :call

  defdelegate transaction(params), to: Transaction, as: :call
end
