defmodule SimEx do
  use Application
  alias SimEx.Random

  def start(_type, _args) do
    :observer.start()
    {:ok, pid} = SimEx.Supervisor.start_link([])
    spawn_clients(Application.get_env(:simex, :clients))
    {:ok, pid}
  end

  def spawn_clients(number) do
    Enum.to_list(1..number)
    |> Flow.from_enumerable
    |> Flow.map(fn _ -> generate_state() end)
    |> Flow.partition
    |> Flow.map(fn state -> SimEx.Supervisor.start_client(state) end)
    |> Flow.partition
    |> Flow.map(&do_work/1)
    |> Flow.run
  end

  def do_work({:ok, pid}), do: SimEx.Client.work(pid)
  def do_work(_), do: nil

  def generate_state do
    sleeptime = Random.rand()
    first = string_of_length(32)
    client_id = "#{first}-#{sleeptime}"
    %{client_id: client_id, sleeptime: sleeptime}
  end

  defp string_of_length(length) do
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" |> String.split("")
    Enum.reduce((1..length), [], fn (_i, acc) ->
      [Enum.random(chars) | acc]
    end) |> Enum.join("")
  end
end
