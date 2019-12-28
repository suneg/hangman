defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new game" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert game.letters == game.letters |> List.to_string |> String.downcase |> String.codepoints
  end
end
