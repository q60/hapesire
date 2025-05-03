defmodule Hapesire.Quotations.Quote do
  use Ash.Resource, domain: Hapesire.Quotations, extensions: [AshJsonApi.Resource]

  json_api do
    type "quote"
  end

  actions do
    read :random
  end

  attributes do
    attribute :text, :string do
      primary_key? true
      allow_nil? false
    end

    attribute :author, :string do
      allow_nil? true
    end
  end
end
