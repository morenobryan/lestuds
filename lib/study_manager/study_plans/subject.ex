defmodule StudyManager.StudyPlans.Subject do
  @moduledoc """
  Represents a subject which the user wants to study when creating its study
  plan
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "subjects" do
    field :color, :string
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name, :description, :color])
    |> validate_required([:name, :description, :color])
  end
end
