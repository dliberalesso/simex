defmodule SimEx.Utils do
  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" |> String.split("")

  @doc """
  Generates a random integer inside a normal distribution.
  Uses `:sleeptime_mean` and `:sleeptime_sd` defined at `config/config.exs`.
  """
  def rand do
    mean = Application.get_env(:simex, :sleeptime_mean)
    sd = Application.get_env(:simex, :sleeptime_sd)
    round(:rand.normal(mean, :math.pow(sd, 2)))
  end

  def string_of_length(length) do
    Enum.reduce((1..length), [], fn (_i, acc) ->
      [Enum.random(@chars) | acc]
    end) |> Enum.join("")
  end
end
