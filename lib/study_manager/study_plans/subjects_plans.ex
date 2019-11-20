defmodule StudyManager.StudyPlans.SubjectsPlans do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subjects_plans" do
    field :subject_id, :id
    field :plan_id, :id

    timestamps()
  end

  @doc false
  def changeset(subjects_plans, attrs) do
    subjects_plans
    |> cast(attrs, [])
    |> validate_required([])
  end
end
