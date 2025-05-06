defmodule HapesireWeb.PlugRouter do
  @moduledoc """
  Main `Plug` router.
  """

  use Plug.Router

  alias Hapesire.Quotations.Quote

  @static "priv/static"
  @en %{
    more: "more",
    about: "A few words",
    hapesire_is: "is a collection of famous inspiring quotes by different authors",
    look_at_this: "Take a look at this unsophisticated basic website. Try pressing the",
    button: "button to see another quote. May you come across an expression that strikes a chord with you",
    however: "However,",
    not_only: "is not only a website, it has a",
    endpoint: "endpoint available at",
    about_quotes_api: "Quotes API",
    about_proverbs_api: "Proverbs API",
    methods: "The following methods are supported",
    languages: "The next languages are available",
    english: "English",
    russian: "Russian",
    chinese: "Chinese",
    default_language: "The default language is English"
  }
  @ru %{
    more: "ещё",
    about: "Пару слов",
    hapesire_is: "&mdash; это собрание известных высказываний и цитат разных людей",
    look_at_this: "Взгляните на этот неискушённый и простой сайт. Попробуйте нажать на кнопку",
    button: "чтобы увидеть другую цитату. Желаю найти высказывание, которое будет по-настоящему Вам близко",
    however: "Но",
    not_only: "&mdash; это не просто веб-сайт, здесь вы так же найдёте",
    endpoint: "сервис, доступный по ссылке",
    about_quotes_api: "API цитат",
    about_proverbs_api: "API пословиц",
    methods: "На данный момент поддерживаются следующие методы",
    languages: "Цитаты доступны на следующих языках",
    english: "английский",
    russian: "русский",
    chinese: "китайский",
    default_language: "Язык по умолчанию &mdash; английский"
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

  get "/en" do
    %{text: text, author: author} = Quote.random!("en")

    html =
      EEx.eval_file(
        "#{@static}/index.heex",
        locale: {:en, :ru},
        translations: @en,
        quote_text: text,
        quote_author: author
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
        locale: {:ru, :en},
        translations: @ru,
        quote_text: text,
        quote_author: author
      )

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end
end
