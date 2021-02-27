defmodule RocketpayWeb.WelcomeControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.Numbers

  describe "index/2" do
    test "when sending a valid file, return the sum", %{conn: conn} do
      params = "numbers"

      response =
        conn
        |> get(Routes.welcome_path(conn, :index, params))
        |> json_response(:ok)

      assert %{"message" => "Welcome to Rocketpay API. Here is the sum result: 52"} = response
    end

    test "when sending a invalid file, return an error", %{conn: conn} do
      params = "invalid"

      response =
        conn
        |> get(Routes.welcome_path(conn, :index, params))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid File"} = response
    end
  end
end
