defmodule StudyManager.Repo.Migrations.CreatePlans do
  use Ecto.Migration

  def change do
    create table(:plans) do
      add :name, :string
      add :start_date, :date
      add :end_date, :date

      timestamps()
    end

  end
end
