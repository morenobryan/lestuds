defmodule StudyManager.Repo do
  use Ecto.Repo,
    otp_app: :study_manager,
    adapter: Ecto.Adapters.Postgres
end
