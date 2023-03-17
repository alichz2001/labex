defmodule Labex.Backends.File do

  @behaviour :gen_event

  def init(opts) do
    IO.inspect(opts)
    {:ok, []}
  end

  def handle_event(event, state) do
    IO.inspect(event, label: "LABEX")
    IO.inspect(state, label: "STATE")
    {:ok, state}
  end

end
