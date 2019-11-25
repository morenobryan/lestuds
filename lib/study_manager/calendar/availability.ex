defmodule StudyManager.Calendar.Availability do
  use Ecto.Schema
  import Ecto.Changeset

  alias StudyManager.StudyPlans.Plan

  schema "availability" do
    field :end_time, :time
    field :start_time, :time
    field :weekday, :integer

    belongs_to(:plan, Plan)

    timestamps()
  end

  @doc false
  def changeset(availability, attrs) do
    availability
    |> cast(attrs, [:weekday, :start_time, :end_time])
    |> validate_required([:weekday, :start_time, :end_time])
  end
end
