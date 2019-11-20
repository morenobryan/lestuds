defmodule StudyManager.Calendar do
  @moduledoc """
  The Calendar context.
  """

  import Ecto.Query, warn: false
  alias StudyManager.Repo

  alias StudyManager.Calendar.Availability

  @doc """
  Returns the list of availability.

  ## Examples

      iex> list_availability()
      [%Availability{}, ...]

  """
  def list_availability do
    Repo.all(Availability)
  end

  @doc """
  Gets a single availability.

  Raises `Ecto.NoResultsError` if the Availability does not exist.

  ## Examples

      iex> get_availability!(123)
      %Availability{}

      iex> get_availability!(456)
      ** (Ecto.NoResultsError)

  """
  def get_availability!(id), do: Repo.get!(Availability, id)

  @doc """
  Creates a availability.

  ## Examples

      iex> create_availability(%{field: value})
      {:ok, %Availability{}}

      iex> create_availability(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_availability(attrs \\ %{}) do
    %Availability{}
    |> Availability.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a availability.

  ## Examples

      iex> update_availability(availability, %{field: new_value})
      {:ok, %Availability{}}

      iex> update_availability(availability, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_availability(%Availability{} = availability, attrs) do
    availability
    |> Availability.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Availability.

  ## Examples

      iex> delete_availability(availability)
      {:ok, %Availability{}}

      iex> delete_availability(availability)
      {:error, %Ecto.Changeset{}}

  """
  def delete_availability(%Availability{} = availability) do
    Repo.delete(availability)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking availability changes.

  ## Examples

      iex> change_availability(availability)
      %Ecto.Changeset{source: %Availability{}}

  """
  def change_availability(%Availability{} = availability) do
    Availability.changeset(availability, %{})
  end

  alias StudyManager.Calendar.StudySession

  @doc """
  Returns the list of study_session.

  ## Examples

      iex> list_study_session()
      [%StudySession{}, ...]

  """
  def list_study_session do
    Repo.all(StudySession)
  end

  @doc """
  Gets a single study_session.

  Raises `Ecto.NoResultsError` if the Study session does not exist.

  ## Examples

      iex> get_study_session!(123)
      %StudySession{}

      iex> get_study_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_study_session!(id), do: Repo.get!(StudySession, id)

  @doc """
  Creates a study_session.

  ## Examples

      iex> create_study_session(%{field: value})
      {:ok, %StudySession{}}

      iex> create_study_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_study_session(attrs \\ %{}) do
    %StudySession{}
    |> StudySession.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a study_session.

  ## Examples

      iex> update_study_session(study_session, %{field: new_value})
      {:ok, %StudySession{}}

      iex> update_study_session(study_session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_study_session(%StudySession{} = study_session, attrs) do
    study_session
    |> StudySession.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a StudySession.

  ## Examples

      iex> delete_study_session(study_session)
      {:ok, %StudySession{}}

      iex> delete_study_session(study_session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_study_session(%StudySession{} = study_session) do
    Repo.delete(study_session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking study_session changes.

  ## Examples

      iex> change_study_session(study_session)
      %Ecto.Changeset{source: %StudySession{}}

  """
  def change_study_session(%StudySession{} = study_session) do
    StudySession.changeset(study_session, %{})
  end
end
