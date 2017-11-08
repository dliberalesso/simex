use Mix.Config

config :simex,
  host: "localhost",
  port: 1883,
  topic: "test",
  clients: 950, #max connections on my machine without ssl
  sleeptime_mean: 500,
  sleeptime_sd: 100
