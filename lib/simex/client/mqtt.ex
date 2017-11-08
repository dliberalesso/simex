defmodule SimEx.Client.MQTT do
  use Hulaaki.Client

  # Callbacks
  def on_connect(message: message, state: state) do
    IO.inspect message
  end

  def on_publish(message: message, state: state) do
    IO.inspect message
  end

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
