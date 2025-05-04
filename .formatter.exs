# Used by "mix format"
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  plugins: [Spark.Formatter, Styler],
  import_deps: [:ash_sqlite, :ash_json_api, :ash, :plug, :reactor]
]
