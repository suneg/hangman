defmodule FibCache do
  
  use Application

  @me __MODULE__

  def start(_type, _args) do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end, name: @me)
  end

  def lookup(n, compute) do
    lookup_in_cache(n)
    |> compute_if_not_in_cache(n, compute)
    |> store_in_cache(n)
  end

  defp lookup_in_cache(n) do
    Agent.get(@me, fn x -> x[n] end)
  end

  defp store_in_cache({ _found_in_cache = false, value }, n) do
    Agent.update(@me, fn x -> Map.put(x, n, value) end)
    value
  end

  defp store_in_cache({ _, value}, _), do: value

  defp compute_if_not_in_cache(nil, n, compute) do
    { false, compute.(n) }
  end

  defp compute_if_not_in_cache(value, _, _) do
    { true, value }
  end
end