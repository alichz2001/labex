defmodule Labex.FileBackend do

  defstruct file: nil

  def init(_opts, conf) do
    conf            = Keyword.get(conf, :conf, [])
    naming_strategy = Keyword.get(conf, :naming_strategy) || raise Labex.ConfigError
    path            = Keyword.get(conf, :path) || raise Labex.ConfigError

    file = open_file(path, naming_strategy)



    {:ok, %Labex.FileBackend{file: file}}
  end

  def handle_event(event, %{file: file} = state) do
    IO.inspect(event, label: "LABEX")
    IO.inspect(state, label: "STATE")
    IO.binwrite(file, format_log(event))
    {:ok, state}
  end

  defp format_log({_, _, {_, txt, _, _}}) do
    txt <> "\n"
  end


  defp new_name(naming_strategy, state \\ [])
  defp new_name(:timestamp, _state) do
    (DateTime.utc_now() |> DateTime.to_unix() |> Integer.to_string()) <> ".log"
  end

  defp open_file(path, naming_strategy) do
    file_name = new_name(naming_strategy)
    File.mkdir_p!(path)
    File.touch!(Path.join(path, file_name) <> ".lock")
    File.open!(Path.join(path, file_name), [:write])
  end

end
