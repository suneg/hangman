defmodule Pyt do
  def swap_a_b(%{ a: a, b: b, c: c }) do
    %{
      a: b,
      b: a,
      c: c
    }
  end
end

result = for a <- 1..100, b <- 1..100, c <- 1..100,
  a < b and b < c,
  a*a + b*b == c*c
  do

  %{ a: a, b: b, c: c }
end

reversed = for v <- result do
  Pyt.swap_a_b(v)
end

all = result ++ reversed |> Enum.uniq

IO.inspect all
IO.puts length(all)