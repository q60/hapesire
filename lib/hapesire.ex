defmodule Hapesire do
  @moduledoc """
  Module with helper functions.
  """
  import Ecto.Query

  @doc """
  Returns port from config.
  """
  @spec serve_port() :: non_neg_integer()
  def serve_port do
    Application.get_env(:hapesire, :port, 4000)
  end

  @doc """
  Returns records count of a table.
  """
  @spec record_count(String.t()) :: non_neg_integer()
  def record_count(table) when table in ~w(quotes proverbs) do
    Hapesire.Repo.aggregate(from(r in table), :count, :id)
  end
end
