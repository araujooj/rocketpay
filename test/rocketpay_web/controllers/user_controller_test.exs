defmodule RocketpayWeb.UsersControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.User

  describe "create/2" do
    test "when all params are valid, create a user", %{conn: conn} do
      params = %{
        name: "Gabriel",
        password: "123456",
        nickname: "araujo",
        email: "gabriel@gmail.com",
        age: 19
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "account" => %{"balance" => "0.00", "id" => _id},
               "email" => "gabriel@gmail.com",
               "name" => "Gabriel",
               "nickname" => "araujo"
             } = response
    end
  end
end
