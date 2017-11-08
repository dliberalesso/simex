defmodule SimEx do
  use Application

  def start(_type, _args) do
    {:ok, pid} = SimEx.Supervisor.start_link([])
    spawn_clients(Application.get_env(:simex, :clients))
    {:ok, pid}
  end

  # Whe should turn this into a GenStage
  def spawn_clients(number) do
    generate_states(number)
    |> Enum.map(fn state -> SimEx.Supervisor.start_client(state) end)
  end

  defp generate_states(number) do
    generate_state = fn(_) ->
      sleeptime = rand()
      first = :crypto.strong_rand_bytes(32) |> Base.encode64 |> binary_part(0, 32)
      client_id = "#{first}-#{sleeptime}"
      %{client_id: client_id, sleeptime: sleeptime}
    end

    Enum.to_list(1..number)
    |> Enum.map(generate_state)
  end

  @doc """
  Generates a random integer inside a normal distribution.
  Uses `:sleeptime_mean` and `:sleeptime_sd` defined at `config/config.exs`.
  """
  def rand do
    mean = Application.get_env(:simex, :sleeptime_mean)
    sd = Application.get_env(:simex, :sleeptime_sd)
    round(mean + :rand.normal * sd)
  end
end
