defmodule Hapesire.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Hapesire.Repo,
      {Plug.Cowboy, scheme: :http, plug: HapesireWeb.PlugRouter, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: Hapesire.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
