defmodule SimEx do
  def hello do
    :hello
  end

  @doc """
  Generates a random integer inside a normal distribution.
  Uses `:sleeptime_mean` and `:sleeptime_sd` defined at `onifg/config.exs`.
  """
  def rand do
    mean = Application.get_env(:simex, :sleeptime_mean)
    sd = Application.get_env(:simex, :sleeptime_sd)
    mean + :rand.normal * sd
  end
end
