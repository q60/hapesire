defmodule HapesireWeb.PlugRouter do
  @moduledoc """
  Main `Plug` router.
  """

  use Plug.Router

  alias Hapesire.Quotations.Quote

  @static "priv/static"

  if Mix.env() == :dev do
    use Plug.Debugger, otp_app: :hapesire
  end

  plug Plug.Static,
    at: "static",
    from: {:hapesire, @static}

  plug :match
  plug :dispatch

  forward("/api", to: HapesireWeb.AshJsonApiRouter)

  get "/" do
    %{text: text, author: author} = Quote.random!("en")

    html = EEx.eval_file("#{@static}/index.heex", quote_text: text, quote_author: author)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end
end
