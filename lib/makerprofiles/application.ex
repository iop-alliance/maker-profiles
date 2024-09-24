defmodule Makerprofiles.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MakerprofilesWeb.Telemetry,
      Makerprofiles.Repo,
      {DNSCluster, query: Application.get_env(:makerprofiles, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Makerprofiles.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Makerprofiles.Finch},
      # Start a worker by calling: Makerprofiles.Worker.start_link(arg)
      # {Makerprofiles.Worker, arg},
      # Start to serve requests, typically the last entry
      MakerprofilesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Makerprofiles.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MakerprofilesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
