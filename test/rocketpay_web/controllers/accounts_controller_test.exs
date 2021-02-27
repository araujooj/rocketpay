defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{User, Account}

  describe "deposit/2" do
    setup %{conn: conn} do
      user_params = %{
        name: "Gabriel",
        password: "123456",
        nickname: "araujo",
        email: "gabriel@gmail.com",
        age: 19
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(user_params)

      conn = put_req_header(conn, "authorization", "Basic dXNlcjoxMjM0NTY=")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make a deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
               "account" => %{"balance" => "50.00", "id" => _id}
             } = response
    end

    test "when params are invalid, receive an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "Invalid Value"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid deposit value!"} == response
    end
  end
end
