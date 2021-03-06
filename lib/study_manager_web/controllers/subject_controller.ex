defmodule StudyManagerWeb.SubjectController do
  use StudyManagerWeb, :controller

  alias StudyManager.StudyPlans
  alias StudyManager.StudyPlans.Subject

  plug Guardian.Plug.EnsureAuthenticated

  def index(conn, _params) do
    subjects = StudyPlans.list_subjects()
    render(conn, "index.html", subjects: subjects)
  end

  def new(conn, _params) do
    changeset = StudyPlans.change_subject(%Subject{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"subject" => subject_params}) do
    subject_params = subject_params |> set_logged_in_user_id(conn)

    case StudyPlans.create_subject(subject_params) do
      {:ok, subject} ->
        conn
        |> put_flash(:info, "Subject created successfully.")
        |> redirect(to: Routes.subject_path(conn, :show, subject))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    subject = StudyPlans.get_subject!(id)
    render(conn, "show.html", subject: subject)
  end

  def edit(conn, %{"id" => id}) do
    subject = StudyPlans.get_subject!(id)
    changeset = StudyPlans.change_subject(subject)
    render(conn, "edit.html", subject: subject, changeset: changeset)
  end

  def update(conn, %{"id" => id, "subject" => subject_params}) do
    subject = StudyPlans.get_subject!(id)

    case StudyPlans.update_subject(subject, subject_params) do
      {:ok, subject} ->
        conn
        |> put_flash(:info, "Subject updated successfully.")
        |> redirect(to: Routes.subject_path(conn, :show, subject))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", subject: subject, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    subject = StudyPlans.get_subject!(id)
    {:ok, _subject} = StudyPlans.delete_subject(subject)

    conn
    |> put_flash(:info, "Subject deleted successfully.")
    |> redirect(to: Routes.subject_path(conn, :index))
  end

  defp set_logged_in_user_id(params, conn) do
    Map.merge(params, %{"user_id" => conn.assigns.current_user.id})
  end
end
