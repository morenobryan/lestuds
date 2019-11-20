defmodule StudyManager.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :name, :string, comment: "The name of the subject"
      add :description, :string, comment: "Short description of the subject"
      add :color, :string, comment: "The color of the subject used on the interface"
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:subjects, [:user_id])
  end
end
