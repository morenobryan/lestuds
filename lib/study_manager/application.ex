defmodule StudyManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias StudyManagerWeb.Endpoint

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: StudyManager.PubSub},
      # Start the Ecto repository
      StudyManager.Repo,
      # Start the endpoint when the application starts
      StudyManagerWeb.Endpoint
      # Starts a worker by calling: StudyManager.Worker.start_link(arg)
      # {StudyManager.Worker, arg},
    ] ++ optional_children()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StudyManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end

  defp optional_children do
    # if the given applications were configured (config.exs, dev.exs, etc)
    # then include them as children to supervise
    include_if_configured = [MocksWeb.Endpoint]

    :study_manager
    |> Application.get_all_env()
    |> Keyword.take(include_if_configured)
    |> Keyword.keys()
  end
end
