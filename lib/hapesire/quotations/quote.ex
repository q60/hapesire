defmodule Hapesire.Quotations.Quote do
  use Ash.Resource, domain: Hapesire.Quotations

  actions do
    defaults [:read]

    create :create
  end

  attributes do
    uuid_primary_key :id

    attribute :text, :string
    attribute :author, :string
  end
end
