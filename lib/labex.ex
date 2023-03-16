defmodule Labex do
  @moduledoc """
  Documentation for `Labex`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Labex.hello()
      :world

  """
  def hello do
    :world
  end

  @behaviour :gen_event

  def init(_args) do

    {:ok, []}
  end

  def handle_event(event, state) do
    IO.inspect(event, label: "LABEX")
    IO.inspect(state, label: "STATE")
    {:ok, state}
  end
end
