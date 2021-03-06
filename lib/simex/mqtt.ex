defmodule SimEx.MQTT do
  require Logger
  use Hulaaki.Client

  def log(atom, [message: message, state: _]) do
    GenServer.cast(SimEx.Monitor, {atom, [
      time: System.system_time(:millisecond),
      client_id: Logger.metadata()[:client],
      msg_type: message.type,
      msg_id: message.id
    ]})
  end

  # Callbacks
  def on_connect([message: message, state: _]) do
    Logger.metadata(client: message.client_id)
  end
  # def on_connect_ack(opts), do: log(opts)
  def on_publish(opts), do: log(:publish, opts)
  # def on_subscribed_publish(opts), do: log(opts)
  # def on_subscribed_publish_ack(opts), do: log(opts)
  # def on_publish_receive(opts), do: log(opts)
  # def on_publish_release(opts), do: log(opts)
  # def on_publish_complete(opts), do: log(opts)
  def on_publish_ack(opts), do: log(:puback, opts)
  # def on_subscribe(opts), do: log(opts)
  # def on_subscribe_ack(opts), do: log(opts)
  # def on_unsubscribe(opts), do: log(opts)
  # def on_unsubscribe_ack(opts), do: log(opts)
  # def on_ping(opts), do: log(opts)
  # def on_ping_response(opts), do: log(opts)
  # def on_ping_response_timeout(opts), do: log(opts)
  # def on_disconnect(opts), do: log(opts)

  # Possible callbacks:
  #   on_connect(opts)
  #   on_connect_ack(opts) do
  #   on_publish(opts)
  #   on_subscribed_publish(opts)
  #   on_subscribed_publish_ack(opts)
  #   on_publish_receive(opts)
  #   on_publish_release(opts)
  #   on_publish_complete(opts)
  #   on_publish_ack(opts)
  #   on_subscribe(opts)
  #   on_subscribe_ack(opts)
  #   on_unsubscribe(opts)
  #   on_unsubscribe_ack(opts)
  #   on_ping(opts)
  #   on_ping_response(opts)
  #   on_ping_response_timeout(opts)
  #   on_disconnect(opts)
  # where opts = [message: message, state: state]
end
