defmodule StudyManagerWeb.Router do
  use StudyManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StudyManagerWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/subjects", SubjectController
    resources "/users", UserController

    get "/auth/:provider", AuthController, :request
    get "/auth/:provider/callback", AuthController, :callback
    post "/auth/:provider/callback", AuthController, :callback
    post "/auth/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", StudyManagerWeb do
  #   pipe_through :api
  # end
end
