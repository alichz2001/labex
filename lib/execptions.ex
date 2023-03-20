defmodule Labex.InvalidModeError do
  defexception []

  @impl true
  def message(_), do: "config error"

end


defmodule Labex.ConfigError do
  defexception []

  @impl true
  def message(_), do: "config error"

end
