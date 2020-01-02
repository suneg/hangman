defmodule Procs do
  def greeter(count) do

    receive do
      { :boom, reason } ->
        exit(reason)
      :reset -> greeter(0)
      {:add, n } -> greeter(count+n)
      msg ->
        IO.puts("#{count}: Hello #{msg}")
        greeter(count)
    end
  end
end


# inner_process = fn -> Process.sleep(10_000) end
# outer_process = fn -> spawn(inner_process); exit(:bad) end
# Enum.each(1..100, fn -> spawn(outer_process) end)