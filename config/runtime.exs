import Config

if config_env() == :prod do
  config :hapesire,
    port: String.to_integer(System.get_env("HAPESIRE_PORT") || "4000")

  config :hapesire, Hapesire.Repo,
    database: System.get_env("HAPESIRE_DB"),
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
end
