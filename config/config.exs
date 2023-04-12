import Config


config :labex, test: "ter"

config :logger,
  backends: [
    :console,
    My.Logger
  ]





config :labex, My.StructuredLogs,
  roller: {:time, {5, :minute}},
  path: Path.expand("./logs/srtuctured/"),
  naming_sterategy: :timestamp
