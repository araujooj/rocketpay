defmodule Rocketpay.NumbersTest do
  use ExUnit.Case, async: true

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "When there is a file with a given name, return a sum of the numbers" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, %{result: 52}}

      assert response == expected_response
    end

    test "When there is no file with a given name, return an error" do
      response = Numbers.sum_from_file("invalid_file")

      expected_response = {:error, %{message: "Invalid File"}}

      assert response == expected_response
    end
  end
end
