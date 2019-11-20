defmodule StudyManagerWeb.PlanControllerTest do
  use StudyManagerWeb.ConnCase

  alias StudyManager.StudyPlans

  @create_attrs %{end_date: ~D[2010-04-17], name: "some name", start_date: ~D[2010-04-17]}
  @update_attrs %{end_date: ~D[2011-05-18], name: "some updated name", start_date: ~D[2011-05-18]}
  @invalid_attrs %{end_date: nil, name: nil, start_date: nil}

  def fixture(:plan) do
    {:ok, plan} = StudyPlans.create_plan(@create_attrs)
    plan
  end

  describe "index" do
    test "lists all plans", %{conn: conn} do
      conn = get(conn, Routes.plan_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Plans"
    end
  end

  describe "new plan" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.plan_path(conn, :new))
      assert html_response(conn, 200) =~ "New Plan"
    end
  end

  describe "create plan" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.plan_path(conn, :create), plan: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.plan_path(conn, :show, id)

      conn = get(conn, Routes.plan_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Plan"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.plan_path(conn, :create), plan: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Plan"
    end
  end

  describe "edit plan" do
    setup [:create_plan]

    test "renders form for editing chosen plan", %{conn: conn, plan: plan} do
      conn = get(conn, Routes.plan_path(conn, :edit, plan))
      assert html_response(conn, 200) =~ "Edit Plan"
    end
  end

  describe "update plan" do
    setup [:create_plan]

    test "redirects when data is valid", %{conn: conn, plan: plan} do
      conn = put(conn, Routes.plan_path(conn, :update, plan), plan: @update_attrs)
      assert redirected_to(conn) == Routes.plan_path(conn, :show, plan)

      conn = get(conn, Routes.plan_path(conn, :show, plan))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, plan: plan} do
      conn = put(conn, Routes.plan_path(conn, :update, plan), plan: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Plan"
    end
  end

  describe "delete plan" do
    setup [:create_plan]

    test "deletes chosen plan", %{conn: conn, plan: plan} do
      conn = delete(conn, Routes.plan_path(conn, :delete, plan))
      assert redirected_to(conn) == Routes.plan_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.plan_path(conn, :show, plan))
      end
    end
  end

  defp create_plan(_) do
    plan = fixture(:plan)
    {:ok, plan: plan}
  end
end
