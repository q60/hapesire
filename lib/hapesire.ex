defmodule Hapesire do
  @moduledoc """
  Module with helper functions.
  """

  @doc """
  Returns port from config.
  """
  @spec serve_port() :: non_neg_integer()
  def serve_port do
    Application.get_env(:hapesire, :port, 4000)
  end
end
