defmodule StudyManager.StudyPlans.Plan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plans" do
    field :end_date, :date
    field :name, :string
    field :start_date, :date

    timestamps()
  end

  @doc false
  def changeset(plan, attrs) do
    plan
    |> cast(attrs, [:name, :start_date, :end_date])
    |> validate_required([:name, :start_date, :end_date])
  end
end
