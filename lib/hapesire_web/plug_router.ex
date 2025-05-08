defmodule HapesireWeb.PlugRouter do
  @moduledoc """
  Main `Plug` router.
  """

  use Plug.Router

  alias Hapesire.Quotations.Quote

  @static "priv/static"
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

  forward("/api", to: HapesireWeb.AshJsonApiRouter)

  get "/" do
    conn
    |> resp(302, "")
    |> put_resp_header("location", "/en")
  end

  get "/:language" when language in ~w(en ru) do
    {current_locale, next_locale} =
      case language do
        "ru" -> {"ru", "en"}
        _ -> {"en", "ru"}
      end

    %{text: text, author: author} = Quote.random!(current_locale)

    html =
      eval_file(
        "index.heex",
        quote_text: text,
        quote_author: author,
        current_locale: current_locale,
        next_locale: next_locale,
        routes: @routes,
        count: %{
          quotes: Hapesire.record_count("quotes"),
          proverbs: Hapesire.record_count("proverbs")
        }
      )

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  defp eval_file(template, bindings) do
    EEx.eval_file(
      "#{@static}/root.heex",
      template: "#{@static}/#{template}",
      bindings: [{:gettext, &HapesireWeb.gettext/2} | bindings]
    )
  end
end
