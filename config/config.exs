use Mix.Config

config :simex,
  host: "localhost",
  port: 8883,
  topic: "test",
  clients: 10,
  sleeptime_mean: 500,
  sleeptime_sd: 100
