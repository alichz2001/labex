defmodule Labex do
  @moduledoc """
  Documentation for `Labex`.
  """

  defmacro __using__(opts) do
    conf = Keyword.merge(opts, Application.get_env(:labex, __CALLER__.module, []))

    mode = Keyword.get(conf, :mode) || raise Labex.InvalidModeError

    quote location: :keep do
      @behaviour :gen_event

      def init(opts), do: unquote(mode).init(opts, unquote(Macro.escape(conf)))

      defdelegate handle_event(event, state), to: unquote(mode)

    end
  end

  defdelegate file(opts), to: Labex.Backends.File, as: :init



end
