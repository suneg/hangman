defmodule Lists do
  def len([]), do: 0
  def len([_h|t]), do: 1 + len(t)

  def sum([]), do: 0
  def sum([h|t]), do: h + sum(t)

  def double([]), do: []
  def double(list), do: map(list, fn x -> 2*x end)

  def square([]), do: []
  def square(list), do: map(list, fn x -> x*x end)

  def map([], _func), do: []
  def map([h|t], func) do
    [ func.(h) | map(t, func) ]
  end

  def even_length([]), do: true
  def even_length([_h|t]), do: !even_length(t)
end