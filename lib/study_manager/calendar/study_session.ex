defmodule StudyManager.Calendar.StudySession do
  @moduledoc """
  The ecto entity for a Study Session
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias StudyManager.StudyPlans.{Subject, Plan}

  schema "study_session" do
    field :end_time, :time
    field :start_time, :time

    belongs_to(:subject, Subject)
    belongs_to(:plan, Plan)

    timestamps()
  end

  @doc false
  def changeset(study_session, attrs) do
    study_session
    |> cast(attrs, [:start_time, :end_time])
    |> validate_required([:start_time, :end_time])
  end
end
