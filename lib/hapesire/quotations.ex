defmodule Hapesire.Quotations do
  @moduledoc """
  `Quotations` domain.
  """

  use Ash.Domain,
    extensions: [AshJsonApi.Domain]

  alias Hapesire.Quotations.Quote

  json_api do
    routes do
      base_route "/quotes", Quote do
        get :random, route: "/random"
        get :random, route: "/random/:language"

        get :by_id, route: "/get/:id"
      end
    end
  end

  resources do
    resource Quote
  end
end
