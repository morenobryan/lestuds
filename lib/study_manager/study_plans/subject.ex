defmodule StudyManager.StudyPlans.Subject do
  @moduledoc """
  Represents a subject which the user wants to study when creating its study
  plan
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias StudyManager.Accounts.User
  alias StudyManager.StudyPlans.Plan

  schema "subjects" do
    field :color, :string
    field :description, :string
    field :name, :string

    belongs_to(:user, User)

    many_to_many(:plans, Plan, join_through: "subjects_plans")

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name, :description, :color, :user_id])
    |> validate_required([:name, :description, :color, :user_id])
  end
end
