defmodule HapesireWeb.PlugRouter do
  @moduledoc """
  Main `Plug` router.
  """

  use Plug.Router

  alias Hapesire.Quotations.Quote

  @static "priv/static"
  @locales ~w(en ru)
  @routes %{
    quotes: HapesireWeb.routes_by_type(:get, "quote"),
    proverbs: HapesireWeb.routes_by_type(:get, "proverb")
  }

  if Mix.env() == :dev do
    use Plug.Debugger, otp_app: :hapesire
  end

  plug Plug.Static,
    at: "static",
    from: {:hapesire, @static}

  plug :match
  plug :dispatch

  forward "/api", to: HapesireWeb.AshJsonApiRouter

  get "/" do
    locale = get_locale(conn)

    %{text: text, author: author} = Quote.random!(locale)

    html =
      eval_file(
        "index.heex",
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

    html = eval_file("docs.heex", locale, routes: @routes)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  defp get_locale(conn) do
    language = fetch_query_params(conn).query_params["lang"]

    (language in @locales && language) || "en"
  end

  defp eval_file(template, locale, bindings) do
    EEx.eval_file(
      "#{@static}/root.heex",
      template: "#{@static}/#{template}",
      current_locale: locale,
      locales: @locales,
      bindings: [
        {:gettext, &HapesireWeb.gettext/2},
        {:bgettext, &HapesireWeb.gettext/3},
        {:current_locale, locale} | bindings
      ]
    )
  end
end
