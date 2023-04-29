defmodule SemesterProject.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SemesterProjectWeb.Telemetry,
      # Start the Ecto repository
      SemesterProject.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SemesterProject.PubSub},
      # Start Finch
      {Finch, name: SemesterProject.Finch},
      # Start the Endpoint (http/https)
      SemesterProjectWeb.Endpoint
      # Start a worker by calling: SemesterProject.Worker.start_link(arg)
      # {SemesterProject.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SemesterProject.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SemesterProjectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
