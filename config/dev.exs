import Config

config :hapesire, Hapesire.Repo,
  database: "./priv/quotes.db",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
