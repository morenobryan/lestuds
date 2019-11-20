defmodule StudyManager.Repo.Migrations.CreatePlans do
  use Ecto.Migration

  def change do
    create table(:plans) do
      add :name, :string, comment: "The name of the study plan"
      add :start_date, :date, comment: "The date that the plan starts"
      add :end_date, :date, comment: "The date that the plan ends"
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:plans, [:user_id])
  end
end
