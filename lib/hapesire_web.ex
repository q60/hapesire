defmodule HapesireWeb do
  @moduledoc """
  Module with helper functions.
  """

  @doc """
  Gettext wrapper function.
  """
  @spec gettext(String.t(), String.t(), map()) :: String.t()
  def gettext(locale, msg_id, bindings \\ %{}) do
    Gettext.with_locale(locale, fn ->
      Gettext.gettext(Hapesire.Gettext, msg_id, bindings)
    end)
  end

  @doc """
  Returns existing routes by request type and resource type.
  """
  @spec routes_by_type(atom(), String.t()) :: [String.t()]
  def routes_by_type(request, type) do
    HapesireWeb.AshJsonApiRouter.spec().paths
    |> Map.filter(fn {_, v} -> Map.from_struct(v)[request].tags == [type] end)
    |> Enum.map(fn {k, _} -> String.upcase("#{request}") <> " " <> k end)
  end
end
