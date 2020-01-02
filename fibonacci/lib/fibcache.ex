defmodule FibCache do
  def use(getAndUpdate) do
    {:ok, pid} = Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
    result = getAndUpdate.(pid)
    Agent.stop(pid)
    result
  end

  def lookup(cache, n) do
    lookup_in_cache(cache, n)
    |> compute_if_not_in_cache(cache, n)
  end

  defp lookup_in_cache(cache, n) do
    Agent.get(cache, fn x -> x[n] end)
  end

  defp compute_if_not_in_cache(nil, cache, n) do
    value = lookup(cache, n-1) + lookup(cache, n-2)
    Agent.get_and_update(cache, fn x -> {x, Map.put(x, n, value)} end)
    value
  end

  defp compute_if_not_in_cache(value, _, _) do
    value
  end
end