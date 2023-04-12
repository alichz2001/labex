defmodule Labex.NamingSterategy do

  @type valid_naming_strategies :: :timestamp

  @spec new_name(valid_naming_strategies, any()) :: String.t()
  def new_name(sterategy, state \\ [])
  def new_name(:timestamp, _state), do: (DateTime.utc_now() |> DateTime.to_unix() |> Integer.to_string()) <> ".log"

end
