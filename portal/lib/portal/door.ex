defmodule Portal.Door do
  use Agent

  def start_link(door) do
    Agent.start_link(fn -> [] end, name: door)
  end

  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  def push(door, value) do
    Agent.update(door, fn list -> [value | list] end)
  end

  def pop(door) do
    Agent.get_and_update(door, fn
      [] -> {:error, []}
      [head | tail] -> {{:ok, head}, tail}
    end)
  end
end
