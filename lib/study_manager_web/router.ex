defmodule StudyManagerWeb.Router do
  use StudyManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug(
      Guardian.Plug.Pipeline,
      error_handler: StudyManagerWeb.AuthController,
      module: StudyManagerWeb.Guardian
    )

    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource, allow_blank: true
    plug StudyManagerWeb.Plugs.SetCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StudyManagerWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/subjects", SubjectController
    resources "/users", UserController
    resources "/availability", AvailabilityController
    resources "/plan", PlanController
    resources "/sessions", StudySessionController
    resources "/registration", RegistrationController, only: [:new, :create]

    get "/auth/:provider", AuthController, :request
    get "/auth/:provider/callback", AuthController, :callback
    post "/auth/:provider/callback", AuthController, :callback
    get "/auth/:provider/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", StudyManagerWeb do
  #   pipe_through :api
  # end
end
