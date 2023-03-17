import Config


config :labex, test: "ter"

config :logger,
  backends: [
    :console,
    My.Logger
  ]



config :labex, My.Logger,
  # mode: :file,
  conf: [
    roller: {:time, {5, :minute}},
    path: URI.new!("./logs"),
    naming_strategy: :timestamp,
    structured_logs: My.StructuredLogs
  ]







config :labex, My.StructuredLogs,
  roller: {:time, {5, :minute}},
  path: URI.new!("./logs/srtuctured"),
  naming_sterategy: :timestamp
