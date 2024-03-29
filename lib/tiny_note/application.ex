defmodule TinyNote.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TinyNoteWeb.Telemetry,
      TinyNote.Repo,
      {DNSCluster, query: Application.get_env(:tiny_note, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TinyNote.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TinyNote.Finch},
      # Start a worker by calling: TinyNote.Worker.start_link(arg)
      # {TinyNote.Worker, arg},
      # Start to serve requests, typically the last entry
      TinyNoteWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TinyNote.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TinyNoteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
