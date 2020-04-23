defmodule MocksWeb.RegistrationController do
  @moduledoc """
  This controller creates users for use in tests
  """

  use MocksWeb, :controller

  alias StudyManager.Accounts

  def create(conn, %{
    "user" => %{
      "email" => email, "full_name" => full_name, "password" => password
    }
  }) do
    digested_password = Security.Hash.digest(password)

    case Accounts.create_user(%{
           "email" => email,
           "full_name" => full_name,
           "password" => digested_password
         }) do
      {:ok, _user} ->
        conn
        |> put_status(200)
        |> json(
          %{
            "data" => %{
              "email" => email,
              "full_name" => full_name,
              "password" => password
            }
          }
        )

      {:error, _changeset} ->
        conn
        |> put_status(500)
        |> json(%{"errors" => "The user couldn't be created."})
    end
  end
end
