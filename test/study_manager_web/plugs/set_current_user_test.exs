defmodule StudyManagerWeb.Plugs.SetCurrentUserTest do
  use ExUnit.Case
  use Plug.Test

  alias StudyManager.Accounts.User
  alias StudyManagerWeb.Guardian.Plug
  alias StudyManagerWeb.Plugs.SetCurrentUser

  test "assigns nil for the current user when no user is logged in" do
    conn =
      :get
      |> conn("/", "")
      |> SetCurrentUser.call(%{})

    refute authenticated?(conn)
  end

  test "finds and assigns the user when the user is in the session, but not assigned" do
    conn =
      :get
      |> conn("/", "")
      |> Plug.sign_in(%User{})
      |> SetCurrentUser.call(%{})

    assert authenticated?(conn)
  end

  defp authenticated?(conn) do
    conn.assigns[:current_user] && conn.assigns[:user_signed_in?] == true
  end
end
