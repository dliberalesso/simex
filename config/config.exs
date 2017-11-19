use Mix.Config

path = fn ->
  {_, _, micro} = now = :os.timestamp()
  {{year, month, day}, {hours, minutes, seconds}} = :calendar.now_to_local_time(now)
  "log/#{year}#{month}#{day}_#{hours}#{minutes}#{seconds}#{div(micro, 1000)}.csv"
end

config :simex,
  host: "localhost",
  port: 1883,
  topic: "test",
  clients: 1000, #max connections on my machine without ssl
  distribution: {:normal, [mean: 1000, sd: 50]}

  config :logger,
    backends: [{LoggerFileBackend, :info}]

  config :logger, :info,
    path: path.(),
    format: "$date,$time,$message\n",
    level: :info
