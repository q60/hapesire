defmodule Hapesire.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Hapesire.Repo,
      {Plug.Cowboy,
       scheme: :http,
       plug: HapesireWeb.PlugRouter,
       options: [
         port: Hapesire.serve_port()
       ]}
    ]

    opts = [strategy: :one_for_one, name: Hapesire.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
