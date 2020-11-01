defmodule StudyManager.StudyPlans.Plan do
  @moduledoc """
  The ecto entity for a Plan
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias StudyManager.Accounts.User
  alias StudyManager.StudyPlans.Subject

  schema "plans" do
    field :end_date, :date
    field :name, :string
    field :start_date, :date

    belongs_to(:user, User)

    many_to_many(:subjects, Subject, join_through: "subjects_plans")

    timestamps()
  end

  @doc false
  def changeset(plan, attrs) do
    plan
    |> cast(attrs, [:name, :start_date, :end_date, :user_id])
    |> validate_required([:name, :start_date, :end_date, :user_id])
  end
end
