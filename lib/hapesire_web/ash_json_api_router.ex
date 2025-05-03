defmodule HapesireWeb.AshJsonApiRouter do
  use AshJsonApi.Router,
    domains: [Hapesire.Quotations],
    open_api: "/open_api"
end
