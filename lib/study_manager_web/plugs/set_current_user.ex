defmodule StudyManagerWeb.Plugs.SetCurrentUser do
  @moduledoc """
  Assigns the user on the session to a controller variable, so that the
  templates can get information about the current user. If the user isn't logged
  in, sets to nil
  """
  import Plug.Conn

  alias StudyManager.Accounts.User
  alias StudyManagerWeb.Guardian.Plug

  @spec init(any()) :: nil
  def init(_params) do
  end

  @spec call(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def call(conn, _params) do
    case user = Plug.current_resource(conn) do
      %User{} ->
        conn
        |> assign(:current_user, user)
        |> assign(:user_signed_in?, true)

      nil ->
        conn
        |> assign(:current_user, nil)
        |> assign(:user_signed_in?, false)
    end
  end
end
