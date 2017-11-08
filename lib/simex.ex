defmodule SimEx do
  # use Application
  #
  # def start(_type, _args) do
  #   SimEx.Supervisor.start_link(name: SimEx.Supervisor)
  # end

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
