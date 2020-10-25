defmodule StudyManagerWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox
  alias Phoenix.ConnTest
  alias StudyManager.Accounts
  alias StudyManager.Accounts.User
  alias StudyManagerWeb.Guardian.Plug, as: Guardian

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      alias StudyManagerWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint StudyManagerWeb.Endpoint

      def create_and_login_user(context) do
        user = create_user()
        conn = signin_user(user)
        {:ok, conn: conn, user: user}
      end

      def login_user(context) do
        conn = signin_user(context.user)

        {:ok, conn: conn, user: context.user}
      end

      def signin_user(%User{} = user) do
        build_conn()
        |> get("/")
        # I don't know exactly why we need to set the state on the next line,
        # but somehow it's the only way of making the sign in process work
        |> Map.update!(:state, fn _ -> :set end)
        |> Guardian.sign_in(user)
        |> send_resp(200, "Flush the session")
      end

      def logout_user(_) do
        conn =
          build_conn()
          |> get("/")
          # I don't know exactly why we need to set the state on the next line,
          # but somehow it's the only way of making the sign in process work
          |> Map.update!(:state, fn _ -> :set end)
          |> Guardian.sign_out()
          |> send_resp(200, "Flush the session")

        {:ok, conn: conn, user: nil}
      end

      defp create_user do
        {:ok, user} =
          Accounts.create_user(%{
            email: "some email",
            full_name: "some full_name",
            password: "some password"
          })

        user
      end
    end
  end

  setup tags do
    :ok = Sandbox.checkout(StudyManager.Repo)

    unless tags[:async] do
      Sandbox.mode(StudyManager.Repo, {:shared, self()})
    end

    {:ok, conn: ConnTest.build_conn()}
  end
end
