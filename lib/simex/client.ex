defmodule SimEx.Client do
  use GenServer
  alias SimEx.MQTT

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(%{} = state) do
    host = Application.get_env(:simex, :host)
    port = Application.get_env(:simex, :port)

    {:ok, mqtt_pid} = MQTT.start_link(%{})

    options = [
      client_id: state[:client_id],
      host: host,
      port: port,
      # ssl: true
    ]

    MQTT.connect(mqtt_pid, options)

    schedule_work(state[:sleeptime])

    {:ok, Map.put(state, :mqtt_pid, mqtt_pid)}
  end

  def handle_info(:publish, state) do
    options = [
      topic: Application.get_env(:simex, :topic),
      message: "#{state[:client_id]}: #{Float.to_string(:rand.uniform)}",
      dup: 0,
      qos: 1,
      retain: 1
    ]

    MQTT.publish(state[:mqtt_pid], options)

    schedule_work(state[:sleeptime])

    {:noreply, state}
  end

  defp schedule_work(time) do
    Process.send_after(self(), :publish, time)
  end
end
