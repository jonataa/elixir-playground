defmodule PingTest do
  use ExUnit.Case
  doctest Ping

  test "it responds to a pong with a ping" do
    pong = spawn(Ping, :start, [])
    send(pong, {:pong, self()})
    :timer.sleep(500)
    assert_receive {:ping, ^pong}
  end

  test "it responds to a ping with a pong" do
    ping = spawn(Ping, :start, [])
    send(ping, {:ping, self()})
    :timer.sleep(500)
    assert_receive {:pong, ^ping}
  end

end
