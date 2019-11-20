defmodule StudyManagerWeb.StudySessionControllerTest do
  use StudyManagerWeb.ConnCase

  alias StudyManager.Calendar

  @create_attrs %{end_time: ~T[14:00:00], start_time: ~T[14:00:00]}
  @update_attrs %{end_time: ~T[15:01:01], start_time: ~T[15:01:01]}
  @invalid_attrs %{end_time: nil, start_time: nil}

  def fixture(:study_session) do
    {:ok, study_session} = Calendar.create_study_session(@create_attrs)
    study_session
  end

  describe "index" do
    test "lists all study_session", %{conn: conn} do
      conn = get(conn, Routes.study_session_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Study session"
    end
  end

  describe "new study_session" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.study_session_path(conn, :new))
      assert html_response(conn, 200) =~ "New Study session"
    end
  end

  describe "create study_session" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.study_session_path(conn, :create), study_session: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.study_session_path(conn, :show, id)

      conn = get(conn, Routes.study_session_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Study session"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.study_session_path(conn, :create), study_session: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Study session"
    end
  end

  describe "edit study_session" do
    setup [:create_study_session]

    test "renders form for editing chosen study_session", %{
      conn: conn,
      study_session: study_session
    } do
      conn = get(conn, Routes.study_session_path(conn, :edit, study_session))
      assert html_response(conn, 200) =~ "Edit Study session"
    end
  end

  describe "update study_session" do
    setup [:create_study_session]

    test "redirects when data is valid", %{conn: conn, study_session: study_session} do
      conn =
        put(conn, Routes.study_session_path(conn, :update, study_session),
          study_session: @update_attrs
        )

      assert redirected_to(conn) == Routes.study_session_path(conn, :show, study_session)

      conn = get(conn, Routes.study_session_path(conn, :show, study_session))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, study_session: study_session} do
      conn =
        put(conn, Routes.study_session_path(conn, :update, study_session),
          study_session: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Study session"
    end
  end

  describe "delete study_session" do
    setup [:create_study_session]

    test "deletes chosen study_session", %{conn: conn, study_session: study_session} do
      conn = delete(conn, Routes.study_session_path(conn, :delete, study_session))
      assert redirected_to(conn) == Routes.study_session_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.study_session_path(conn, :show, study_session))
      end
    end
  end

  defp create_study_session(_) do
    study_session = fixture(:study_session)
    {:ok, study_session: study_session}
  end
end
