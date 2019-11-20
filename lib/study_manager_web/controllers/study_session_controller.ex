defmodule StudyManagerWeb.StudySessionController do
  use StudyManagerWeb, :controller

  alias StudyManager.Calendar
  alias StudyManager.Calendar.StudySession

  def index(conn, _params) do
    study_session = Calendar.list_study_session()
    render(conn, "index.html", study_session: study_session)
  end

  def new(conn, _params) do
    changeset = Calendar.change_study_session(%StudySession{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"study_session" => study_session_params}) do
    case Calendar.create_study_session(study_session_params) do
      {:ok, study_session} ->
        conn
        |> put_flash(:info, "Study session created successfully.")
        |> redirect(to: Routes.study_session_path(conn, :show, study_session))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    study_session = Calendar.get_study_session!(id)
    render(conn, "show.html", study_session: study_session)
  end

  def edit(conn, %{"id" => id}) do
    study_session = Calendar.get_study_session!(id)
    changeset = Calendar.change_study_session(study_session)
    render(conn, "edit.html", study_session: study_session, changeset: changeset)
  end

  def update(conn, %{"id" => id, "study_session" => study_session_params}) do
    study_session = Calendar.get_study_session!(id)

    case Calendar.update_study_session(study_session, study_session_params) do
      {:ok, study_session} ->
        conn
        |> put_flash(:info, "Study session updated successfully.")
        |> redirect(to: Routes.study_session_path(conn, :show, study_session))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", study_session: study_session, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    study_session = Calendar.get_study_session!(id)
    {:ok, _study_session} = Calendar.delete_study_session(study_session)

    conn
    |> put_flash(:info, "Study session deleted successfully.")
    |> redirect(to: Routes.study_session_path(conn, :index))
  end
end
