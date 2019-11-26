defmodule StudyManagerWeb.RegistrationController do
  @moduledoc """
  Registration controller responsible for handling new registrations in the system
  """

  use StudyManagerWeb, :controller

  alias StudyManager.Accounts
  alias StudyManager.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{
        "user" => %{"email" => email, "full_name" => full_name, "password" => password}
      }) do
    digested_password = Security.Hash.digest(password)

    case Accounts.create_user(%{
           "email" => email,
           "full_name" => full_name,
           "password" => digested_password
         }) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
