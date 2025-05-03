defmodule HapesireWeb.AshJsonApiRouter do
  @moduledoc """
  `AshJsonApi` router provider.
  """

  use AshJsonApi.Router,
    domains: [Hapesire.Quotations],
    open_api: "/open_api"
end
