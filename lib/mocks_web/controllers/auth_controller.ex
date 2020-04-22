defmodule MocksWeb.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use MocksWeb, :controller

  plug Ueberauth

  alias Security.Hash
  alias StudyManager.Accounts
  alias StudyManager.Accounts.User
  alias StudyManagerWeb.Guardian.Plug
  alias Ueberauth.Strategy.Helpers

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    digested_password = Hash.digest(password)

    case user = Accounts.get_user(%{email: email, password: digested_password}) do
      %User{} ->
        conn
        |> put_status(200)
        |> Plug.sign_in(user)
        |> json(%{
          "data" => %{
            "email" => user.email,
            "full_name" => user.full_name,
            "password" => password
          }
        })

      nil ->
        conn
        |> put_status(200)
        |> json(%{"errors" => "User not found with those credentials."})
    end
  end

  def delete(conn, _params) do
    conn
    |> put_status(200)
    |> Plug.sign_out()
    |> json(%{"data" => "You have been logged out"})
  end
end
