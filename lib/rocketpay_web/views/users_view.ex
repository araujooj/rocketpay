defmodule RocketpayWeb.UsersView do
  alias Rocketpay.User

  def render("create.json", %{user: %User{id: id, name: name, nickname: nickname, email: email}}) do
    %{
      id: id,
      name: name,
      nickname: nickname,
      email: email
    }
  end
end
