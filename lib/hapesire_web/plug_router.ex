defmodule HapesireWeb.PlugRouter do
  @moduledoc """
  Main `Plug` router.
  """

  use Plug.Router

  if Mix.env() == :dev do
    use Plug.Debugger, otp_app: :hapesire
  end

  plug(:match)
  plug(:dispatch)

  forward("/api/redoc",
    to: Redoc.Plug.RedocUI,
    init_opts: [
      spec_url: "/api/open_api"
    ]
  )

  forward("/api", to: HapesireWeb.AshJsonApiRouter)
end
