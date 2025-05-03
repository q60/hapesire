import Config

config :logger, level: :warning
config :ash, disable_async?: true

config :hapesire, Hapesire.Repo,
  database: "../priv/quotes.db",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10
