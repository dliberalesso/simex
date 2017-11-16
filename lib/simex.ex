defmodule SimEx do
  use Application
  alias SimEx.Utils

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
    |> Flow.run
  end

  def generate_state do
    sleeptime = Utils.rand()
    first = Utils.string_of_length(32)
    client_id = "#{first}-#{sleeptime}"
    %{client_id: client_id, sleeptime: sleeptime}
  end
end
