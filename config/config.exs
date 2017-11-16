use Mix.Config

path = fn ->
  {_, _, micro} = now = :os.timestamp()
  {date = {year, month, day}, {hours, minutes, seconds}} = :calendar.now_to_local_time(now)
  {date, {hours, minutes, seconds, mili = div(micro, 1000)}}
  "log/#{year}#{month}#{day}_#{hours}#{minutes}#{seconds}#{mili}.csv"
end

config :simex,
  host: "localhost",
  port: 1883,
  topic: "test",
  clients: 835, #max connections on my machine without ssl
  sleeptime_mean: 500,
  sleeptime_sd: 100,
  csv_file_path: path.()

  config :logger,
    backends: [{LoggerFileBackend, :info}]

  config :logger, :info,
    path: path.(),
    format: "$date,$time,$message\n",
    level: :info
