defmodule Hapesire.Quotations.Quote do
  @moduledoc """
  `Quote` resource.
  """
  use Ash.Resource,
    domain: Hapesire.Quotations,
    extensions: [AshJsonApi.Resource],
    data_layer: AshSqlite.DataLayer

  require Ash.Sort

  @languages [
    :en,
    :ru
  ]

  json_api do
    type "quote"
    default_fields [:text, :author]
  end

  sqlite do
    table "quotes"

    repo Hapesire.Repo
  end

  code_interface do
    define :random do
      args optional: :language
      get? true
    end

    define :by_id do
      args [:id]
      get? true
    end
  end

  actions do
    read :by_id do
      description "gets a quote by id"
    end

    read :random do
      description "gets a random quote by language"

      argument :language, :atom do
        description "quote language"

        allow_nil? true
        default :en

        constraints one_of: @languages
      end

      filter expr(language == ^arg(:language))
      prepare build(limit: 1, sort: Ash.Sort.expr_sort(fragment("RANDOM()")))
    end
  end

  attributes do
    integer_primary_key :id

    attribute :text, :string do
      description "quote text"

      allow_nil? false
    end

    attribute :author, :string do
      description "quote author"

      allow_nil? true
    end

    attribute :language, :atom do
      description "quote language"

      allow_nil? false
    end
  end
end
