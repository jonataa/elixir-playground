defmodule Chat do
  @moduledoc """
  Documentation for `Chat`.
  """
  def receive_message(message) do
    IO.puts(message)
  end

  def receive_message_for_moebi(message, from) do
    IO.puts(message)
    send_message(from, "Chicken?")
  end

  def send_message(:moebi@localhost, message) do
    spawn_task(__MODULE__, :receive_message_for_moebi, :moebi@localhost, [message, Node.self()])
  end

  def send_message(recipient, message) do
    spawn_task(__MODULE__, :receive_message, recipient, [message])
  end

  def spawn_task(module, fun, recipient, args) do
    remote_supervisor(recipient)
    |> Task.Supervisor.async(module, fun, args)
    |> Task.await()
  end

  defp remote_supervisor(recipient) do
    Application.get_env(:chat, :remote_supervisor, fn recipient ->
      {Chat.TaskSupervisor, recipient}
    end).(recipient)
  end
end
