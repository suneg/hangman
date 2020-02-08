defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def display_letters(letters) do
    letters
    |> Enum.join(" ")
  end
end
