use Mix.Config

config :simex,
  host: "localhost",
  port: 1883,
  topic: "test",
  clients: 1600, #max connections on my machine without ssl
  distribution: {:normal, [mean: 1000, sd: 50]}

  config :logger,
    backends: [{LoggerFileBackend, :info}]

  config :logger, :info,
    path: "log/cenario_05.csv",
    format: "$message\n",
    level: :info
