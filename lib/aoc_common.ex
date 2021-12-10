defmodule AocCommon do
  @moduledoc """
  Macro to import common modules.
  """

  defmacro __using__(_) do
    quote do
      alias AocCommon.Input
      alias AocCommon.CountedSet
      alias AocCommon.Deque
    end
  end
end
