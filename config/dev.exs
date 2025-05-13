import Config

config :hapesire, Hapesire.Repo,
  database: "./deps/hapesire_db/collection.db",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
