
shopping = [
  { "1 dozen", "eggs" },
  { "1 ripe", "melon" },
  { "4", "apples" },
  { "2 boxes", "tea" },
]

IO.puts "quantity | item "
IO.puts "---------------------"

output = EEx.eval_string """
<%= for { quantity, item } <- list do %>
<%= String.pad_leading(quantity, 8) %> | <%= item %>
<% end %>
""", [ list: shopping ], trim: true

IO.puts output
