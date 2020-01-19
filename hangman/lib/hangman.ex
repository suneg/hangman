defmodule Hangman do

  def new_game() do
    # count and store num of invocations... where/how to store it?
    count_games()
    IO.puts "Game count #{Agent.get(:game_counter, fn count -> count end)}"
    { :ok, pid } = Supervisor.start_child(Hangmans.Supervisor, [])
    pid
  end

  def tally(game_pid) do
    GenServer.call(game_pid, {:tally})
  end

  def make_move(pid, guess) do
    GenServer.call(pid, {:make_move, guess})
  end

  defp count_games() do
    if(Process.whereis(:game_counter) == nil) do
      {:ok, pid } = Agent.start_link(fn -> 0 end )
      Process.register(pid, :game_counter)
    end

    Agent.update(:game_counter, fn count -> count + 1 end)
  end
end
