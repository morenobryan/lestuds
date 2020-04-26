defmodule StudyManagerWeb.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use StudyManagerWeb, :controller

  plug Ueberauth

  alias Security.Hash
  alias StudyManager.Accounts
  alias StudyManager.Accounts.User
  alias StudyManagerWeb.Guardian.Plug
  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    case conn.assigns.user_signed_in? do
      true ->
        conn
        |> put_flash(:info, "You are already logged in.")
        |> redirect(to: "/")
      _ ->
        changeset = Accounts.change_user(%User{})

        render(
          conn,
          "request.html",
          callback_url: Helpers.callback_url(conn),
          changeset: changeset
        )
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    email = auth.info.email
    password = Hash.digest(auth.credentials.other.password)

    case user = Accounts.get_user(%{"email" => email, "password" => password}) do
      %User{} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> Plug.sign_in(user)
        |> redirect(to: "/")

      nil ->
        conn
        |> put_flash(:error, "User not found with those credentials.")
        |> redirect(to: Routes.auth_path(conn, :request, :identity))
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out")
    |> Plug.sign_out()
    |> redirect(to: "/")
  end

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:info, "You need to login to access this page")
    |> redirect(to: Routes.auth_path(conn, :request, :identity))
  end
end
