defmodule StringUpcaseTest do
  use ExUnit.Case
  doctest StringUpcase

  test "it responds an upcase string when receive message" do
    pid = spawn(StringUpcase, :start, [])
    send(pid, {"foo bar", self()})
    assert_receive {:ok, "FOO BAR"}
  end

  test "it responds an error when it sent an integer" do
    pid = spawn(StringUpcase, :start, [])
    send(pid, {123, self()})
    assert_receive {:error, _}
  end
end
