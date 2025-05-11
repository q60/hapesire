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
  Returns path with static assets from config.
  """
  @spec static() :: String.t()
  def static do
    Application.get_env(:hapesire, :static, "priv/static")
  end

  @doc """
  Returns locales from config.
  """
  @spec locales() :: [String.t()]
  def locales do
    Application.get_env(:hapesire, :locales, ~w(en))
  end

  @doc """
  Returns records count of a table.
  """
  @spec record_count(String.t()) :: non_neg_integer()
  def record_count(table) when table in ~w(quotes proverbs) do
    Hapesire.Repo.aggregate(from(r in table), :count, :id)
  end
end
