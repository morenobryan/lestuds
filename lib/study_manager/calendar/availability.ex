defmodule StudyManager.Calendar.Availability do
  use Ecto.Schema
  import Ecto.Changeset

  schema "availability" do
    field :end_time, :time
    field :start_time, :time
    field :weekday, :integer
    field :plan_id, :id

    timestamps()
  end

  @doc false
  def changeset(availability, attrs) do
    availability
    |> cast(attrs, [:weekday, :start_time, :end_time])
    |> validate_required([:weekday, :start_time, :end_time])
  end
end
