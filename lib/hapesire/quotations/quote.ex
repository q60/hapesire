defmodule Hapesire.Quotations.Quote do
  @moduledoc """
  `Quote` resource.
  """

  use Ash.Resource,
    domain: Hapesire.Quotations,
    extensions: [AshJsonApi.Resource],
    data_layer: AshSqlite.DataLayer

  require Ash.Sort

  @langs_regex ~r/en|ru/

  json_api do
    type "quote"
    default_fields [:text, :author]
  end

  sqlite do
    table "quotes_en"
    table "quotes_ru"

    repo Hapesire.Repo
  end

  code_interface do
    define :random, args: [optional: :lang], get?: true
  end

  actions do
    read :random do
      argument :lang, :string do
        allow_nil? true

        constraints match: @langs_regex,
                    max_length: 2
      end

      get? true

      prepare fn query, _ ->
        lang =
          case query.arguments do
            args when args == %{} -> "en"
            args -> args.lang
          end

        Ash.Query.set_context(query, %{data_layer: %{table: "quotes_#{lang}"}})
      end

      prepare build(limit: 1, sort: Ash.Sort.expr_sort(fragment("RANDOM()")))
    end
  end

  attributes do
    attribute :id, :string do
      source :text
      primary_key? true
      allow_nil? false
    end

    attribute :text, :string do
      allow_nil? false
    end

    attribute :author, :string do
      allow_nil? true
    end
  end
end
