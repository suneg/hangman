defmodule FibonacciTest do
  use ExUnit.Case
  doctest Fibonacci

  test "Bunch of fib numbers" do
    assert Fibonacci.fib(5) == 5
    assert Fibonacci.fib(10) == 55
    assert Fibonacci.fib(15) == 610
    assert Fibonacci.fib(50) == 12586269025
    assert Fibonacci.fib(100) == 354224848179261915075
  end
end
