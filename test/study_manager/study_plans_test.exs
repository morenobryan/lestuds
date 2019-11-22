defmodule StudyManager.StudyPlansTest do
  use StudyManager.DataCase

  alias StudyManager.StudyPlans

  describe "subjects" do
    alias StudyManager.StudyPlans.Subject

    @valid_attrs %{color: "some color", description: "some description", name: "some name"}
    @update_attrs %{
      color: "some updated color",
      description: "some updated description",
      name: "some updated name"
    }
    @invalid_attrs %{color: nil, description: nil, name: nil}

    def subject_fixture(attrs \\ %{}) do
      {:ok, subject} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StudyPlans.create_subject()

      subject
    end

    test "list_subjects/0 returns all subjects" do
      subject = subject_fixture()
      assert StudyPlans.list_subjects() == [subject]
    end

    test "get_subject!/1 returns the subject with given id" do
      subject = subject_fixture()
      assert StudyPlans.get_subject!(subject.id) == subject
    end

    test "create_subject/1 with valid data creates a subject" do
      assert {:ok, %Subject{} = subject} = StudyPlans.create_subject(@valid_attrs)
      assert subject.color == "some color"
      assert subject.description == "some description"
      assert subject.name == "some name"
    end

    test "create_subject/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StudyPlans.create_subject(@invalid_attrs)
    end

    test "update_subject/2 with valid data updates the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{} = subject} = StudyPlans.update_subject(subject, @update_attrs)
      assert subject.color == "some updated color"
      assert subject.description == "some updated description"
      assert subject.name == "some updated name"
    end

    test "update_subject/2 with invalid data returns error changeset" do
      subject = subject_fixture()
      assert {:error, %Ecto.Changeset{}} = StudyPlans.update_subject(subject, @invalid_attrs)
      assert subject == StudyPlans.get_subject!(subject.id)
    end

    test "delete_subject/1 deletes the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{}} = StudyPlans.delete_subject(subject)
      assert_raise Ecto.NoResultsError, fn -> StudyPlans.get_subject!(subject.id) end
    end

    test "change_subject/1 returns a subject changeset" do
      subject = subject_fixture()
      assert %Ecto.Changeset{} = StudyPlans.change_subject(subject)
    end
  end

  describe "plans" do
    alias StudyManager.StudyPlans.Plan

    @valid_attrs %{end_date: ~D[2010-04-17], name: "some name", start_date: ~D[2010-04-17]}
    @update_attrs %{
      end_date: ~D[2011-05-18],
      name: "some updated name",
      start_date: ~D[2011-05-18]
    }
    @subject_association_attrs %{
      color: "some updated color",
      description: "some updated description",
      name: "some updated name"
    }
    @invalid_attrs %{end_date: nil, name: nil, start_date: nil}

    def plan_fixture(attrs \\ %{}) do
      {:ok, plan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StudyPlans.create_plan()

      plan
    end

    test "list_plans/0 returns all plans" do
      plan = plan_fixture()
      assert StudyPlans.list_plans() == [plan]
    end

    test "get_plan!/1 returns the plan with given id" do
      plan = plan_fixture()
      assert StudyPlans.get_plan!(plan.id) == plan
    end

    test "create_plan/1 with valid data creates a plan" do
      assert {:ok, %Plan{} = plan} = StudyPlans.create_plan(@valid_attrs)
      assert plan.end_date == ~D[2010-04-17]
      assert plan.name == "some name"
      assert plan.start_date == ~D[2010-04-17]
    end

    test "create_plan/2 with valid data creates a plan and a subject associated to it" do
      assert {:ok, %Plan{} = plan} =
               StudyPlans.create_plan(@valid_attrs, @subject_association_attrs)

      assert plan.end_date == ~D[2010-04-17]
      assert plan.name == "some name"
      assert plan.start_date == ~D[2010-04-17]
    end

    test "create_plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StudyPlans.create_plan(@invalid_attrs)
    end

    test "update_plan/2 with valid data updates the plan" do
      plan = plan_fixture()
      assert {:ok, %Plan{} = plan} = StudyPlans.update_plan(plan, @update_attrs)
      assert plan.end_date == ~D[2011-05-18]
      assert plan.name == "some updated name"
      assert plan.start_date == ~D[2011-05-18]
    end

    test "update_plan/2 with invalid data returns error changeset" do
      plan = plan_fixture()
      assert {:error, %Ecto.Changeset{}} = StudyPlans.update_plan(plan, @invalid_attrs)
      assert plan == StudyPlans.get_plan!(plan.id)
    end

    test "delete_plan/1 deletes the plan" do
      plan = plan_fixture()
      assert {:ok, %Plan{}} = StudyPlans.delete_plan(plan)
      assert_raise Ecto.NoResultsError, fn -> StudyPlans.get_plan!(plan.id) end
    end

    test "change_plan/1 returns a plan changeset" do
      plan = plan_fixture()
      assert %Ecto.Changeset{} = StudyPlans.change_plan(plan)
    end
  end
end
