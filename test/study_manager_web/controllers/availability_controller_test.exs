defmodule StudyManagerWeb.AvailabilityControllerTest do
  use StudyManagerWeb.ConnCase

  alias StudyManager.Calendar

  @create_attrs %{end_time: ~T[14:00:00], start_time: ~T[14:00:00], weekday: 42}
  @update_attrs %{end_time: ~T[15:01:01], start_time: ~T[15:01:01], weekday: 43}
  @invalid_attrs %{end_time: nil, start_time: nil, weekday: nil}

  def fixture(:availability) do
    {:ok, availability} = Calendar.create_availability(@create_attrs)
    availability
  end

  describe "index" do
    test "lists all availability", %{conn: conn} do
      conn = get(conn, Routes.availability_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Availability"
    end
  end

  describe "new availability" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.availability_path(conn, :new))
      assert html_response(conn, 200) =~ "New Availability"
    end
  end

  describe "create availability" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.availability_path(conn, :create), availability: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.availability_path(conn, :show, id)

      conn = get(conn, Routes.availability_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Availability"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.availability_path(conn, :create), availability: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Availability"
    end
  end

  describe "edit availability" do
    setup [:create_availability]

    test "renders form for editing chosen availability", %{conn: conn, availability: availability} do
      conn = get(conn, Routes.availability_path(conn, :edit, availability))
      assert html_response(conn, 200) =~ "Edit Availability"
    end
  end

  describe "update availability" do
    setup [:create_availability]

    test "redirects when data is valid", %{conn: conn, availability: availability} do
      conn =
        put(conn, Routes.availability_path(conn, :update, availability),
          availability: @update_attrs
        )

      assert redirected_to(conn) == Routes.availability_path(conn, :show, availability)

      conn = get(conn, Routes.availability_path(conn, :show, availability))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, availability: availability} do
      conn =
        put(conn, Routes.availability_path(conn, :update, availability),
          availability: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Availability"
    end
  end

  describe "delete availability" do
    setup [:create_availability]

    test "deletes chosen availability", %{conn: conn, availability: availability} do
      conn = delete(conn, Routes.availability_path(conn, :delete, availability))
      assert redirected_to(conn) == Routes.availability_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.availability_path(conn, :show, availability))
      end
    end
  end

  defp create_availability(_) do
    availability = fixture(:availability)
    {:ok, availability: availability}
  end
end
