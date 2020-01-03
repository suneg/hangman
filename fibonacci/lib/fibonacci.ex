defmodule Fibonacci do

  def fib(n) do
    FibCache.lookup(n, &compute/1)
  end

  defp compute(n) do
    fib(n-1) + fib(n-2)
  end
end