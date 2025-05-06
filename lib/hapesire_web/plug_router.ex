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
    conn
    |> resp(302, "")
    |> put_resp_header("location", "/en")
  end

  get "/en" do
    %{text: text, author: author} = Quote.random!("en")

    html =
      EEx.eval_file(
        "#{@static}/index.heex",
        quote_text: text,
        quote_author: author,
        gettext: &gettext/2,
        current_locale: "en",
        next_locale: "ru"
      )

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  get "/ru" do
    %{text: text, author: author} = Quote.random!("ru")

    html =
      EEx.eval_file(
        "#{@static}/index.heex",
        quote_text: text,
        quote_author: author,
        gettext: &gettext/2,
        current_locale: "ru",
        next_locale: "en"
      )

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  defp gettext(locale, msg_id, bindings \\ %{}) do
    Gettext.with_locale(locale, fn ->
      Gettext.gettext(Hapesire.Gettext, msg_id, bindings)
    end)
  end
end
