defmodule SimEx.Random do
  def rand do
    default = {:normal, [mean: 0, sd: 1]} # standard normal distribution
    Application.get_env(:simex, :distribution, default)
    |> do_rand
  end

  defp do_rand({:normal, [mean: mean, sd: sd]}) do
    :rand.normal(mean, :math.pow(sd, 2))
    |> round
  end

  defp do_rand({:triangle, [a: a, b: b, c: c]}) do
    r = (1.0 - :rand.uniform())
    if (r < ((c - a) / (b - a))) do
      a + :math.sqrt(r * (b - a) * (c - a))
    else
      b - :math.sqrt((1 - r) * (b - a) * (b - c))
    end
  end

  # TODO: Erlang distribution
end
