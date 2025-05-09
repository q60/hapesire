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
  @spec routes_by_type(atom(), String.t()) :: %{
          String.t() => %{
            description: String.t(),
            params: [
              %{
                name: String.t() | atom(),
                description: String.t() | nil,
                type: atom()
              }
            ]
          }
        }
  def routes_by_type(request, type) do
    HapesireWeb.AshJsonApiRouter.spec().paths
    |> Map.new(fn {k, v} -> {k, Map.from_struct(v)} end)
    |> Map.filter(fn {_, v} -> v[request].tags == [type] end)
    |> Map.new(fn {k, %{^request => v}} ->
      params = extract_params(v.parameters)

      {String.upcase("#{request}") <> " " <> k,
       %{
         description: v.description,
         params: params
       }}
    end)
  end

  defp extract_params(params_list) do
    params_list
    |> Enum.filter(fn parameter -> parameter.in == :path and parameter.required end)
    |> Enum.map(fn parameter ->
      schema = Map.from_struct(parameter.schema)

      %{
        name: parameter.name,
        description: parameter.description,
        type: schema.type
      }
    end)
  end
end
