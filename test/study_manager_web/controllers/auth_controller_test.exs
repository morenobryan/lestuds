defmodule StudyManagerWeb.AuthControllerTest do
  use StudyManagerWeb.ConnCase

  import StudyManager.Factory

  @invalid_attrs %{email: "invalid@email.com", password: "invalid"}

  def fixture(:user) do
    insert(:user)
  end

  describe "login" do
    setup [:create_user]

    test "logs in when the credentials are valid", %{conn: conn, user: user} do
      conn = post(
        conn,
        Routes.auth_path(conn, :callback, :identity),
        user: %{email: user.email, password: "test"}
      )

      assert redirected_to(conn) == Routes.page_path(conn, :index)
      assert get_flash(conn, :info) == "Successfully authenticated."
    end

    test "errors when the credentials are invalid", %{conn: conn} do
      conn = post(
        conn,
        Routes.auth_path(conn, :callback, :identity),
        user: @invalid_attrs
      )

      assert redirected_to(conn) == Routes.auth_path(conn, :request, :identity)
      assert get_flash(conn, :error) == "User not found with those credentials."
    end
  end

  describe "login for already logged in users" do
    setup [:create_and_login_user]

    test "redirects to home page", %{conn: conn, user: user} do
      conn = post(
        conn,
        Routes.auth_path(conn, :callback, :identity),
        user: %{email: user.email, password: user.password}
      )

      conn = get(conn, Routes.auth_path(conn, :request, :identity))

      assert redirected_to(conn) == Routes.page_path(conn, :index)
      assert get_flash(conn, :info) == "You are already logged in."
    end
  end

  describe "logout" do
    setup [:create_and_login_user]

    test "logs out successfully", %{conn: conn} do
      conn = get(conn, Routes.auth_path(conn, :delete, :identity))

      assert redirected_to(conn) == Routes.page_path(conn, :index)
      assert get_flash(conn, :info) == "You have been logged out"
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
