use Mix.Config

config :simex,
  mqtt_host: "localhost",
  port: 1883,
  topic: "test",
  clients: 10,
  sleeptime_mean: 500,
  sleeptime_sd: 100
