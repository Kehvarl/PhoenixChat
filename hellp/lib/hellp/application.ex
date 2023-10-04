defmodule Hellp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HellpWeb.Telemetry,
      # Start the Ecto repository
      Hellp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Hellp.PubSub},
      # Start Finch
      {Finch, name: Hellp.Finch},
      # Start the Endpoint (http/https)
      HellpWeb.Endpoint
      # Start a worker by calling: Hellp.Worker.start_link(arg)
      # {Hellp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hellp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HellpWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
