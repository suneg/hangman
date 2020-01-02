defmodule FibCache do
  def use(getAndUpdate) do
    {:ok, pid} = Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
    result = getAndUpdate.(pid)
    Agent.stop(pid)
    result
  end

  def lookup(cache, n) do
    Agent.get(cache, fn x -> x[n] end)
    |> compute_and_cache_if_missing(cache, n)
  end

  defp compute_and_cache_if_missing(value, cache, n) do
    cond do
      value != nil -> value
      value == nil ->
        value = lookup(cache, n-1) + lookup(cache, n-2)
        Agent.get_and_update(cache, fn x -> {x, Map.put(x, n, value)} end)
        value
    end
  end
end