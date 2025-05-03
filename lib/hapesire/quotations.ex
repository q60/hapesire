defmodule Hapesire.Quotations do
  @moduledoc false
  use Ash.Domain, extensions: [AshJsonApi.Domain]

  alias Hapesire.Quotations.Quote

  json_api do
    routes do
      base_route "/quote", Quote do
        index :random
      end

      base_route "/quote/:lang", Quote do
        index :random
      end
    end
  end

  resources do
    resource Quote
  end
end
