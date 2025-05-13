import Config

config :ash, disable_async?: true

config :hapesire, Hapesire.Repo,
  database: "./deps/hapesire_db/collection.db",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :logger, level: :warning
