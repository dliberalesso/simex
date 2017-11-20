defmodule SimEx.Monitor do
  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_cast({:publish, publish}, state) do
    {:noreply, [publish | state]}
  end

  def handle_cast({:puback, puback}, state) do
    index = Enum.find_index(state, fn x ->
      puback[:client_id] == x[:client_id] and puback[:msg_id] == x[:msg_id]
    end)
    {publish, list} = List.pop_at(state, index)
    duration = puback[:time] - publish[:time]
    Logger.info("#{duration}")
    {:noreply, list}
  end
end
