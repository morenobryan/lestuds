defmodule StudyManager.Repo.Migrations.AddUserIdToPlans do
  use Ecto.Migration

  def change do
    alter table(:plans) do
      add :user_id, references(:users, on_delete: :nothing)
    end

    create index(:plans, [:user_id])
  end
end
