#
# Reference document:  https://docs.bitfinex.com/v2/reference#ws-public-order-books
#
defmodule Ladder.BitfinexEthBtc do
  use WebSockex
  @exchanage "bitfinex"
  @symbol "tETHBTC"
  @url "wss://api-pub.bitfinex.com/ws/2"
  @msg %{ "event": "subscribe", "channel": "book", "symbol": @symbol }
  @database "ladders"

  def start_link(_) do
    IO.puts("riki debug here : Ladder.BitfinexEthBtc.start_link")
    {:ok, pid} = WebSockex.start_link(@url, __MODULE__, %{})
    subscribe(pid)
    {:ok, pid}
  end

  def handle_frame({type, msg}, state) do
#    IO.puts "Received Message - Type: #{inspect type} -- Message: #{inspect msg}"
    msg
    |> Poison.decode!
    |> handle_decode_msg

    {:ok, state}
  end

  defp handle_decode_msg(%{"event" => msg}) do
    msg
  end

  defp handle_decode_msg(decoded_msg) do
    decoded_msg
    |> get_value
    |> write_data
  end

  def handle_cast({:send, {type, msg} = frame}, state) do
    IO.puts "Sending #{type} frame with payload: #{msg}"
    {:reply, frame, state}
  end

  def subscribe(pid) do
    WebSockex.send_frame(pid, subscription_frame)
  end

  defp subscription_frame do
    {:text, Poison.encode!(@msg)}
  end

  # Riki will move this function to other location later. just for testing now. ^^
  defp write_data(value) do
    data = %LadderSeries{}
    data = %{data | fields: %{data.fields | value: value}}
    data = %{data | tags: %{data.tags | exchange: "bitfinex", symbol: "btcusdt"}}

    Ladder.Database.Manager.write(data)
    |> IO.inspect
  end

  defp get_value([_channel_ID, [[price, _count, _amount] | _tail]]) do
    price
  end

  defp get_value([_channel_ID, [price, _count, _amount]]) do
    price
  end
end
