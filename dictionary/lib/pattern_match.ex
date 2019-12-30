defmodule PatternMatch do
  def swap({ a, b}) do
    { b, a }
  end

  def equal({ a, a }), do: true
  
  def equal({ b, b }), do: false
end