defmodule FibonacciTest do
  use ExUnit.Case
  doctest Fibonacci

  test "Bunch of fib numbers" do
    assert Fibonacci.fib(5) == 5
    assert Fibonacci.fib(10) == 55
    assert Fibonacci.fib(15) == 610
  end
end
