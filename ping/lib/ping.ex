defmodule Ping do
  def start do
    loop()
  end

  def loop() do
    receive do
      {:ping, from} -> 
        IO.puts "     <- Pong"
        :timer.sleep 500
        send(from, {:pong, self()})
      {:pong, from} -> 
        IO.puts "Ping ->"
        :timer.sleep 500
        send(from, {:ping, self()})
    end
    loop()
  end
end
