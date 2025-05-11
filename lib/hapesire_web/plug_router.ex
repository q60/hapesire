defmodule HapesireWeb.PlugRouter do
  @moduledoc """
  Main `Plug` router.
  """

  use Plug.Router
  use HapesireWeb.Templates

  alias Hapesire.Quotations.Quote

  @static Hapesire.static()
  @locales Hapesire.locales()
  @routes %{
    quotes: HapesireWeb.routes_by_type(:get, "quote"),
    proverbs: HapesireWeb.routes_by_type(:get, "proverb")
  }

  if Mix.env() == :dev do
    use Plug.Debugger, otp_app: :hapesire
  end

  plug Plug.Static,
    at: "static",
    from: {:hapesire, @static},
    only: ~w(styles assets)

  plug :match
  plug :dispatch

  forward "/api", to: HapesireWeb.AshJsonApiRouter

  get "/" do
    locale = get_locale(conn)

    %{text: text, author: author} = Quote.random!(locale)

    html =
      eval_index(
        locale,
        quote_text: text,
        quote_author: author,
        count: %{
          quotes: Hapesire.record_count("quotes"),
          proverbs: Hapesire.record_count("proverbs")
        }
      )

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  get "/docs" do
    locale = get_locale(conn)

    html = eval_docs(locale, routes: @routes)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  defp get_locale(conn) do
    language = fetch_query_params(conn).query_params["lang"]

    (language in @locales && language) || "en"
  end
end
