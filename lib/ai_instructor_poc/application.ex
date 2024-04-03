defmodule AiInstructorPoc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AiInstructorPocWeb.Telemetry,
      AiInstructorPoc.Repo,
      {DNSCluster, query: Application.get_env(:ai_instructor_poc, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AiInstructorPoc.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AiInstructorPoc.Finch},
      # Start a worker by calling: AiInstructorPoc.Worker.start_link(arg)
      # {AiInstructorPoc.Worker, arg},
      # Start to serve requests, typically the last entry
      AiInstructorPocWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AiInstructorPoc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AiInstructorPocWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
