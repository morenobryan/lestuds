defmodule StudyManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :full_name, :string, comment: "The user's full name"
      add :email, :string, comment: "The user email"
      add :password, :string, comment: "The user password, encrypted"

      timestamps()
    end
  end
end
