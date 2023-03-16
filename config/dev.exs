import Config


config :labex, test: "ter"

config :logger,
  backends: [
    :console,
    {LoggerAmqpBackend, :amqp_log}
  ]
