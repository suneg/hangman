defmodule Procs do
  def greeter(count) do

    receive do
      :reset -> greeter(0)
      {:add, n } -> greeter(count+n)
      msg ->
        IO.puts("#{count}: Hello #{msg}")
        greeter(count)
    end
  end
end
