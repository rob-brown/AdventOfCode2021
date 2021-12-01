defmodule AocCommon.Input do
  def lines(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
  end

  def numbers(path) do
    path |> lines |> Stream.map(&String.to_integer/1)
  end
end
