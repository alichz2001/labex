defmodule Labex do
  @moduledoc """
  Documentation for `Labex`.
  """

  defmacro __using__(opts) do
    opts = Keyword.merge(opts, Application.get_env(:labex, __CALLER__.module, []))

    mode = Keyword.get(opts, :mode) || raise Labex.InvalidModeError
    init_method = :file

    quote location: :keep do
      @behaviour :gen_event

      defdelegate init(opts), to: Labex, as: unquote(init_method)
      defdelegate handle_event(), to: Labex


    end
  end

  defdelegate file(opts), to: Labex.Backends.File, as: :init



end
