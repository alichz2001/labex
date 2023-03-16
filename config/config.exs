import Config


config :labex, test: "ter"

config :logger,
  backends: [
    :console,
    {My.Logger, :my_logger}
  ]

config :labex, My.Logger,
  roller: {:time, {5, :minute}},
  path: URI.new("./logs"),
  naming_strategy: :timestamp,
  structured_logs: My.StructuredLogs

config :labbex, My.StructuredLogs,
  roller: {:time. {5, :minute}},
  path: URI.new("./logs/srtuctured"),
  naming_sterategy: :timestamp
