defmodule StudyManager.Repo.Migrations.CreateStudySession do
  use Ecto.Migration

  def change do
    create table(:study_session) do
      add :start_time, :time
      add :end_time, :time
      add :subject_id, references(:subjects, on_delete: :nothing)
      add :plan_id, references(:plans, on_delete: :nothing)

      timestamps()
    end

    create index(:study_session, [:subject_id])
    create index(:study_session, [:plan_id])
  end
end
