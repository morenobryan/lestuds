defmodule StudyManager.StudyPlans.Plan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plans" do
    field :end_date, :date
    field :name, :string
    field :start_date, :date
    field :user_id, :id

    many_to_many(:subject, Subject, join_through: "subjects_plans")

    timestamps()
  end

  @doc false
  def changeset(plan, attrs) do
    plan
    |> cast(attrs, [:name, :start_date, :end_date, :user_id])
    |> validate_required([:name, :start_date, :end_date, :user_id])
  end
end
