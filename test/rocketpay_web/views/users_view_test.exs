defmodule RockepayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Gabriel",
      password: "123456",
      nickname: "araujo",
      email: "gabriel@gmail.com",
      age: 19
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      Rocketpay.create_user(params)

    response = render(RocketpayWeb.UsersView, "create.json", user: user)

    expected_response = %{
      account: %{balance: Decimal.new("0.00"), id: account_id},
      email: "gabriel@gmail.com",
      id: user_id,
      name: "Gabriel",
      nickname: "araujo"
    }

    assert expected_response == response
  end
end
