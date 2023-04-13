defmodule Labex do
  @moduledoc """
  Documentation for `Labex`.
  """

  options_schema = [
    mode: [
      type: {:tuple, [:atom, :keyword_list, {:list, :atom}]},
      required: :true,
      default: Labex.FileBackend
    ],
    conf: [
      type: :keyword_list,
      keys: [
        path: [
          type: :string,
          required: :true
        ],
        roller: [
          type: {:or, [{:tuple, [:atom, {:tuple, [:integer, :atom]}]}]}
        ],
        naming_strategy: [
          type: :atom,
          default: :timestamp
        ]
      ]
    ]
  ]

  defmacro __using__(opts) do

    # config options has more priority
    opts = Keyword.merge(opts, Application.get_env(:labex, __CALLER__.module, []))

    schema = NimbleOptions.new!(unquote(options_schema))
    opts = NimbleOptions.validate!(opts, schema)


    quote location: :keep do
      @behaviour :gen_event

      # use unquote(Keyword.get(opts, :mode))

      def init(opts), do: unquote(Keyword.get(opts, :mode)).init(opts, unquote(Macro.escape(opts)))

      defdelegate handle_event(event, state), to: unquote(Keyword.get(opts, :mode))

    end
  end


end
