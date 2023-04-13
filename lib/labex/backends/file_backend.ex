defmodule Labex.FileBackend do
  alias Labex.FileBackend

  alias Labex.{FileBackend, NamingSterategy}

  defstruct file: nil

  def init(_opts, conf) do
    conf            = Keyword.get(conf, :conf, [])
    naming_strategy = Keyword.get(conf, :naming_strategy) || raise Labex.ConfigError
    path            = Keyword.get(conf, :path) || raise Labex.ConfigError
    roller          = Keyword.get(conf, :roller) || {:time, {5, :minute}}

    file = open_file(path, naming_strategy)
    schedule_roller(roller)

    {:ok, %FileBackend{file: file}}
  end

  def handle_event(event, %{file: file} = state) do
    IO.inspect(event, label: "LABEX")
    IO.inspect(state, label: "STATE")

    format_log(event)
    |> case do
      {:ok, log_str} ->
        IO.binwrite(file, log_str)
      {:ignore, _reasone} ->
        :todo
      _ ->
        :todo
    end

    {:ok, state}
  end


  @spec format_log({any(), any(), {any(), String.t(), any(), any()}}) :: {:ok, String.t()} | {:ignore, atom()}
  defp format_log({_, _, {_, txt, _, _}}), do: {:ok, txt <> "\n"}
  defp format_log(_), do: {:ignore, :not_matched}

  defoverridable([format_log: 1])



  @spec open_file(Path.t(), NamingSterategy.valid_naming_strategies()) :: IO.device()
  defp open_file(path, naming_strategy) do
    file_name = NamingSterategy.new_name(naming_strategy)
    File.mkdir_p!(path)
    File.touch!(Path.join(path, file_name) <> ".lock")
    File.open!(Path.join(path, file_name), [:write])
  end

  defp schedule_roller({:time, roller}), do:
    Process.send_after(self(), :roll_log_file, translate_time(roller))

  defp translate_time({n, :minute}), do: n * 60


  defmacro __using__(opts) do
    
  end

end
