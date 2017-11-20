defmodule SimEx.Info do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, 30, name: __MODULE__)
  end

  def init(sec) do
    schedule_work() # Schedule work to be performed on start
    {:ok, sec}
  end

  def handle_info(:work, sec) do
    if sec == 30, do: IO.puts("\n")
    IO.puts("#{sec}sec: #{inspect(Supervisor.count_children(SimEx.Supervisor))}")
    schedule_work()
    {:noreply, sec+30}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 30000) # In 2 hours
  end
end
