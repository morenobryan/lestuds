defmodule MocksWeb.Router do
  @moduledoc """
  These routes are intended to setup preconditions for integration tests to
  run, like creating users, logging them in and etc.
  """
  use MocksWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session

    plug(
      Guardian.Plug.Pipeline,
      error_handler: StudyManagerWeb.AuthController,
      module: StudyManagerWeb.Guardian
    )

    plug StudyManagerWeb.Plugs.SetCurrentUser
  end

  scope "/mocks", MocksWeb do
    pipe_through :api

    resources "/registration", RegistrationController, only: [:create]
    resources "/auth", AuthController, only: [:create, :delete]
  end
end
