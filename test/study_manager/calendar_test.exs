defmodule StudyManager.CalendarTest do
  use StudyManager.DataCase

  alias StudyManager.Calendar

  describe "availability" do
    alias StudyManager.Calendar.Availability

    @valid_attrs %{end_time: ~T[14:00:00], start_time: ~T[14:00:00], weekday: 42}
    @update_attrs %{end_time: ~T[15:01:01], start_time: ~T[15:01:01], weekday: 43}
    @invalid_attrs %{end_time: nil, start_time: nil, weekday: nil}

    def availability_fixture(attrs \\ %{}) do
      {:ok, availability} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Calendar.create_availability()

      availability
    end

    test "list_availability/0 returns all availability" do
      availability = availability_fixture()
      assert Calendar.list_availability() == [availability]
    end

    test "get_availability!/1 returns the availability with given id" do
      availability = availability_fixture()
      assert Calendar.get_availability!(availability.id) == availability
    end

    test "create_availability/1 with valid data creates a availability" do
      assert {:ok, %Availability{} = availability} = Calendar.create_availability(@valid_attrs)
      assert availability.end_time == ~T[14:00:00]
      assert availability.start_time == ~T[14:00:00]
      assert availability.weekday == 42
    end

    test "create_availability/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calendar.create_availability(@invalid_attrs)
    end

    test "update_availability/2 with valid data updates the availability" do
      availability = availability_fixture()
      assert {:ok, %Availability{} = availability} = Calendar.update_availability(availability, @update_attrs)
      assert availability.end_time == ~T[15:01:01]
      assert availability.start_time == ~T[15:01:01]
      assert availability.weekday == 43
    end

    test "update_availability/2 with invalid data returns error changeset" do
      availability = availability_fixture()
      assert {:error, %Ecto.Changeset{}} = Calendar.update_availability(availability, @invalid_attrs)
      assert availability == Calendar.get_availability!(availability.id)
    end

    test "delete_availability/1 deletes the availability" do
      availability = availability_fixture()
      assert {:ok, %Availability{}} = Calendar.delete_availability(availability)
      assert_raise Ecto.NoResultsError, fn -> Calendar.get_availability!(availability.id) end
    end

    test "change_availability/1 returns a availability changeset" do
      availability = availability_fixture()
      assert %Ecto.Changeset{} = Calendar.change_availability(availability)
    end
  end

  describe "study_session" do
    alias StudyManager.Calendar.StudySession

    @valid_attrs %{end_time: ~T[14:00:00], start_time: ~T[14:00:00]}
    @update_attrs %{end_time: ~T[15:01:01], start_time: ~T[15:01:01]}
    @invalid_attrs %{end_time: nil, start_time: nil}

    def study_session_fixture(attrs \\ %{}) do
      {:ok, study_session} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Calendar.create_study_session()

      study_session
    end

    test "list_study_session/0 returns all study_session" do
      study_session = study_session_fixture()
      assert Calendar.list_study_session() == [study_session]
    end

    test "get_study_session!/1 returns the study_session with given id" do
      study_session = study_session_fixture()
      assert Calendar.get_study_session!(study_session.id) == study_session
    end

    test "create_study_session/1 with valid data creates a study_session" do
      assert {:ok, %StudySession{} = study_session} = Calendar.create_study_session(@valid_attrs)
      assert study_session.end_time == ~T[14:00:00]
      assert study_session.start_time == ~T[14:00:00]
    end

    test "create_study_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calendar.create_study_session(@invalid_attrs)
    end

    test "update_study_session/2 with valid data updates the study_session" do
      study_session = study_session_fixture()
      assert {:ok, %StudySession{} = study_session} = Calendar.update_study_session(study_session, @update_attrs)
      assert study_session.end_time == ~T[15:01:01]
      assert study_session.start_time == ~T[15:01:01]
    end

    test "update_study_session/2 with invalid data returns error changeset" do
      study_session = study_session_fixture()
      assert {:error, %Ecto.Changeset{}} = Calendar.update_study_session(study_session, @invalid_attrs)
      assert study_session == Calendar.get_study_session!(study_session.id)
    end

    test "delete_study_session/1 deletes the study_session" do
      study_session = study_session_fixture()
      assert {:ok, %StudySession{}} = Calendar.delete_study_session(study_session)
      assert_raise Ecto.NoResultsError, fn -> Calendar.get_study_session!(study_session.id) end
    end

    test "change_study_session/1 returns a study_session changeset" do
      study_session = study_session_fixture()
      assert %Ecto.Changeset{} = Calendar.change_study_session(study_session)
    end
  end
end
