defmodule StudyManager.Repo.Migrations.AddUserIdToSubjects do
  use Ecto.Migration

  def change do
    alter table(:subjects) do
      add :user_id, references(:users, on_delete: :nothing)
    end

    create index(:subjects, [:user_id])
  end
end
