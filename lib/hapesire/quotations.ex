defmodule Hapesire.Quotations do
  use Ash.Domain, extensions: [AshJsonApi.Domain]

  json_api do
    routes do
      base_route "/quote", Hapesire.Quotations.Quote do
        index :random
      end
    end
  end

  resources do
    resource Hapesire.Quotations.Quote
  end
end
