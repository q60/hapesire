defmodule Hapesire.MixProject do
  use Mix.Project

  def project do
    [
      app: :hapesire,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      consolidate_protocols: Mix.env() != :dev,
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Hapesire.Application, []}
    ]
  end

  defp deps do
    [
      {:hapesire_db, app: false, compile: false, git: "https://codeberg.org/q60/hapesire-db", branch: "main"},
      {:slime, "~> 1.0"},
      {:gettext, "~> 0.26"},
      {:ash_sqlite, "~> 0.2"},
      {:plug_cowboy, "~> 2.0"},
      {:open_api_spex, "~> 3.0"},
      {:ash_json_api,
       git: "https://github.com/ash-project/ash_json_api", ref: "6767710fa6cfffdbeeb421aac6d22ce95530f4c7"},
      {:sourceror, "~> 1.8", only: [:dev, :test]},
      {:ash, "~> 3.0"},
      {:igniter, "~> 0.5", only: [:dev, :test]},
      {:styler, "~> 1.4", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [test: ["ash.setup --quiet", "test"]]
  end

  defp elixirc_paths(:test), do: elixirc_paths(:dev) ++ ["test/support"]

  defp elixirc_paths(_), do: ["lib"]
end
