defmodule StringUpcase do
  def start do
    receive do
      {str, from} when is_bitstring(str) -> 
        send(from, {:ok, String.upcase(str)})
      {notstr, from} ->
        send(from, {:error, inspect notstr})
    end
  end
end
