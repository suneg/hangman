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

  test "state isn't changed for :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "First occurence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "Second occurence of letter is already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a bad guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "q")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized wrong" do
    game = Game.new_game("w")
    game = Game.make_move(game, "a")
    assert game.turns_left == 6
    game = Game.make_move(game, "b")
    assert game.turns_left == 5
    game = Game.make_move(game, "c")
    assert game.turns_left == 4
    game = Game.make_move(game, "d")
    assert game.turns_left == 3
    game = Game.make_move(game, "e")
    assert game.turns_left == 2
    game = Game.make_move(game, "f")
    assert game.turns_left == 1
    game = Game.make_move(game, "g")
    assert game.game_state == :lost
  end

  test "a guessed word is a won game" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"c", :bad_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")

    Enum.reduce(moves, game, fn ({guess, state}, acc) ->
      new_state = Game.make_move(acc, guess)
      assert new_state.game_state == state
      new_state
    end)
  end

  test "only allow a valid ascii character when guessing" do

    invalid_guesses = [
      "?",
      "ab",
      "2",
      "ø",
      "A"
    ]

    for guess <- invalid_guesses do
      game = Game.new_game("wibble")
      |> Game.make_move(guess)

      assert game.game_state == :invalid_guess
    end
  end
end
