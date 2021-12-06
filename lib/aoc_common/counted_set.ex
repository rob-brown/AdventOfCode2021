defmodule AocCommon.CountedSet do
  defstruct [:internal_map]

  def new() do
    %__MODULE__{internal_map: %{}}
  end

  def new(enumerable) do
    for x <- enumerable, into: new() do
      x
    end
  end

  def put(set, key) do
    put_many(set, key, 1)
  end

  def put_many(%__MODULE__{internal_map: map}, key, n) do
    new_map = Map.update(map, key, n, &(&1 + n))
    %__MODULE__{internal_map: new_map}
  end

  def count_of(%__MODULE__{internal_map: map}, key) do
    Map.get(map, key, 0)
  end
end

defimpl Enumerable, for: AocCommon.CountedSet do
  def count(_) do
    {:error, __MODULE__}
  end

  def member?(%@for{internal_map: map}, key) do
    {:ok, Map.has_key?(map, key)}
  end

  def slice(_) do
    {:error, __MODULE__}
  end

  def reduce(%@for{internal_map: map}, acc, fun) do
    map |> Map.to_list() |> Enumerable.List.reduce(acc, fun)
  end
end

defimpl Collectable, for: AocCommon.CountedSet do
  def into(initial) do
    collector = fn
      set, {:cont, item} ->
        AocCommon.CountedSet.put(set, item)

      set, :done ->
        set

      _, :halt ->
        :ok
    end

    {initial, collector}
  end
end
