defmodule StudyManager.Repo.Migrations.CreateSubjectsPlans do
  use Ecto.Migration

  def change do
    create table(:subjects_plans, primary_key: false) do
      add :subject_id, references(:subjects, on_delete: :nothing)
      add :plan_id, references(:plans, on_delete: :nothing)
    end

    create index(:subjects_plans, [:subject_id])
    create index(:subjects_plans, [:plan_id])
  end
end
