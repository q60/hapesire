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
    define :random, args: [optional: :language], get?: true
    define :by_id, args: [:id], get?: true
  end

  actions do
    read :by_id

    read :random do
      argument :language, :atom do
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
      allow_nil? false
    end

    attribute :author, :string do
      allow_nil? true
    end

    attribute :language, :atom do
      allow_nil? false
    end
  end
end
