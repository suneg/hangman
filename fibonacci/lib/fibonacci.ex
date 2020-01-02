defmodule Fibonacci do

  def fib(n) do
    FibCache.use(fn cache ->
      FibCache.lookup(cache, n)
    end)
  end
end