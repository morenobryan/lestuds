defmodule StudyManagerWeb.AvailabilityController do
  use StudyManagerWeb, :controller

  alias StudyManager.Calendar
  alias StudyManager.Calendar.Availability

  def index(conn, _params) do
    availability = Calendar.list_availability()
    render(conn, "index.html", availability: availability)
  end

  def new(conn, _params) do
    changeset = Calendar.change_availability(%Availability{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"availability" => availability_params}) do
    case Calendar.create_availability(availability_params) do
      {:ok, availability} ->
        conn
        |> put_flash(:info, "Availability created successfully.")
        |> redirect(to: Routes.availability_path(conn, :show, availability))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    availability = Calendar.get_availability!(id)
    render(conn, "show.html", availability: availability)
  end

  def edit(conn, %{"id" => id}) do
    availability = Calendar.get_availability!(id)
    changeset = Calendar.change_availability(availability)
    render(conn, "edit.html", availability: availability, changeset: changeset)
  end

  def update(conn, %{"id" => id, "availability" => availability_params}) do
    availability = Calendar.get_availability!(id)

    case Calendar.update_availability(availability, availability_params) do
      {:ok, availability} ->
        conn
        |> put_flash(:info, "Availability updated successfully.")
        |> redirect(to: Routes.availability_path(conn, :show, availability))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", availability: availability, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    availability = Calendar.get_availability!(id)
    {:ok, _availability} = Calendar.delete_availability(availability)

    conn
    |> put_flash(:info, "Availability deleted successfully.")
    |> redirect(to: Routes.availability_path(conn, :index))
  end
end
