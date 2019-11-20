defmodule StudyManager.Calendar.StudySession do
  use Ecto.Schema
  import Ecto.Changeset

  schema "study_session" do
    field :end_time, :time
    field :start_time, :time
    field :subject_id, :id
    field :plan_id, :id

    timestamps()
  end

  @doc false
  def changeset(study_session, attrs) do
    study_session
    |> cast(attrs, [:start_time, :end_time])
    |> validate_required([:start_time, :end_time])
  end
end
