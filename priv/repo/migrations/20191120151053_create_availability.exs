defmodule StudyManager.Repo.Migrations.CreateAvailability do
  use Ecto.Migration

  def change do
    create table(:availability) do
      add :weekday, :integer
      add :start_time, :time
      add :end_time, :time
      add :plan_id, references(:plans, on_delete: :nothing)

      timestamps()
    end

    create index(:availability, [:plan_id])
  end
end
