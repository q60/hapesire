defmodule Hapesire.Quotations.Proverb do
  @moduledoc """
  `Proverb` resource.
  """

  use Ash.Resource,
    domain: Hapesire.Quotations,
    extensions: [AshJsonApi.Resource],
    data_layer: AshSqlite.DataLayer

  require Ash.Sort

  @languages [
    :en,
    :zh
  ]

  json_api do
    type "proverb"
    default_fields [:text]
  end

  sqlite do
    table "proverbs"

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
      description "gets a proverb by id"
    end

    read :random do
      description "gets a random proverb by language"

      argument :language, :atom do
        description "proverb language"

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
      description "proverb"

      allow_nil? false
    end

    attribute :language, :atom do
      description "proverb language"

      allow_nil? false
    end
  end
end
