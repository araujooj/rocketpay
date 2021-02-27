defmodule RocketpayWeb.AccountsControllerTest do
  alias Rocketpay.{User, Account}
  use RocketpayWeb.ConnCase, async: true

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

  describe "withdraw/2" do
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

    test "when all params are valid, make a withdraw", %{conn: conn, account_id: account_id} do
      deposit_params = %{"value" => "50.00"}
      withdraw_params = %{"value" => "25.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, deposit_params))
        |> post(Routes.accounts_path(conn, :withdraw, account_id, withdraw_params))
        |> json_response(:ok)

      assert withdraw_params = response
    end
  end

  describe "transaction/2" do
    setup %{conn: conn} do
      from_user_params = %{
        name: "Gabriel",
        password: "123456",
        nickname: "araujo",
        email: "gabriel@gmail.com",
        age: 19
      }

      to_user_params = %{
        name: "Gabriel2",
        password: "123456",
        nickname: "araujo2",
        email: "gabriel2@gmail.com",
        age: 19
      }

      {:ok, %User{account: %Account{id: from_account_id}}} =
        Rocketpay.create_user(from_user_params)

      {:ok, %User{account: %Account{id: to_account_id}}} = Rocketpay.create_user(to_user_params)

      conn = put_req_header(conn, "authorization", "Basic dXNlcjoxMjM0NTY=")

      {:ok, conn: conn, from_account_id: from_account_id, to_account_id: to_account_id}
    end

    test "when all params are valid, make a transaction from one account to another", %{
      conn: conn,
      from_account_id: from_account_id,
      to_account_id: to_account_id
    } do
      deposit_params = %{"value" => "50.00"}
      transaction_params = %{from: from_account_id, to: to_account_id, value: "10.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, from_account_id, deposit_params))
        |> post(Routes.accounts_path(conn, :transaction, transaction_params))
        |> json_response(:ok)

      assert transaction_params = response
    end
  end
end
