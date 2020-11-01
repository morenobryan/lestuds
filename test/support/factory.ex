defmodule StudyManager.Factory do
  @moduledoc """
  The base factory class
  """
  use ExMachina.Ecto, repo: StudyManager.Repo

  alias Security.Hash
  alias StudyManager.Accounts.User
  alias StudyManager.Calendar.{Availability, StudySession}
  alias StudyManager.StudyPlans.{Plan, Subject}

  def user_factory do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      full_name: "Bryan Bryerson",
      password: Hash.digest("test")
    }
  end

  def availability_factory do
    %Availability{
      weekday: 42,
      start_time: "14:00:00",
      end_time: "14:00:00"
    }
  end

  def study_session_factory do
    %StudySession{
      start_time: "14:00:00",
      end_time: "14:00:00",
      subject: build(:subject),
      plan: build(:plan)
    }
  end

  def plan_factory do
    %Plan{
      name: "Bryan Bryerson",
      end_date: "2010-04-17",
      start_date: "2010-04-17",
      user: build(:user)
    }
  end

  def subject_factory do
    %Subject{
      name: "Bryan Bryerson",
      description: "some description",
      color: "#FF00FF",
      user: build(:user)
    }
  end
end
