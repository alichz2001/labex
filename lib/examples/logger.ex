defmodule My.Logger do
  use Labex,
    mode: Labex.FileBackend,
    conf: [
      roller: {:time, {5, :minute}},
      path: "./logs/",
      naming_strategy: :timestamp,
      # structured_logs: My.StructuredLogs
    ]



end
