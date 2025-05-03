defmodule HapesireWeb.PlugRouter do
  use Plug.Router

  if Mix.env() == :dev do
    use Plug.Debugger, otp_app: :hapesire
  end

  plug(:match)
  plug(:dispatch)

  forward("/api/swaggerui",
    to: OpenApiSpex.Plug.SwaggerUI,
    init_opts: [
      path: "/api/open_api",
      default_model_expand_depth: 4
    ]
  )

  forward("/api/redoc",
    to: Redoc.Plug.RedocUI,
    init_opts: [
      spec_url: "/api/open_api"
    ]
  )

  forward("/api", to: HapesireWeb.AshJsonApiRouter)
end
