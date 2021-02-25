defmodule RocketpayWeb.UsersView do
  alias Rocketpay.{User, Account}

  def render("create.json", %{
        user: %User{
          account: %Account{id: account_id, balance: balance},
          id: id,
          name: name,
          nickname: nickname,
          email: email
        }
      }) do
    %{
      id: id,
      name: name,
      nickname: nickname,
      email: email,
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end
end
