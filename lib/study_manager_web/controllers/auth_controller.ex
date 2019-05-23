defmodule StudyManagerWeb.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use StudyManagerWeb, :controller

  plug Ueberauth

  alias StudyManager.Accounts
  alias StudyManager.Accounts.User
  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "request.html", callback_url: Helpers.callback_url(conn), changeset: changeset)
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    email = auth.info.email
    password = auth.credentials.other.password

    case user = Accounts.get_user(%{email: email, password: password}) do
      %User{} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> configure_session(renew: true)
        |> redirect(to: "/")

      nil ->
        conn
        |> put_flash(:error, "User not found with those credentials.")
        |> redirect(to: "/")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
