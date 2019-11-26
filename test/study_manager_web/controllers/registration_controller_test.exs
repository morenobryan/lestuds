defmodule StudyManagerWeb.RegistrationControllerTest do
  use StudyManagerWeb.ConnCase

  import StudyManager.Factory

  @invalid_attrs %{email: nil, full_name: nil, password: nil}

  describe "new registration" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.registration_path(conn, :new))
      assert html_response(conn, 200) =~ "Registration"
    end
  end

  describe "register a new user (create)" do
    test "redirects to home page when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.registration_path(conn, :create), user: string_params_with_assocs(:user))

      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.registration_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Registration"
    end
  end
end
