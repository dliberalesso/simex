defmodule SimEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :simex,
      version: "0.2.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {SimEx, []}
    ]
  end

  defp deps do
    [
      {:hulaaki, "~> 0.1.0"},
      {:flow, "~> 0.11"},
      {:benchee, "~> 0.10", only: :dev}
    ]
  end
end
