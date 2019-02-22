#%{
#   "e": "trade",  # Event type
#   "E": 123456789,   # Event time
#   "s": "BNBBTC",    # Symbol
#   "a": 12345,       # Aggregate trade ID
#   "p": "0.001",     # Price
#   "q": "100",       # Quantity
#   "f": 100,         # First trade ID
#   "l": 105,         # Last trade ID
#   "T": 123456785,   # Trade time
#   "m": true,        # Is the buyer the market maker?
#   "M": true         # Ignore
#}



defmodule Ladder.BitfinexEthBtc do
  use WebSockex
  @url "wss://api-pub.bitfinex.com/ws/2"
  @msg %{ "event": "subscribe", "channel": "book", "symbol": "tETHBTC" }

  def start_link(_) do
    IO.puts("riki debug here : Ladder.BitfinexEthBtc.start_link")
    {:ok, pid} = WebSockex.start_link(@url, __MODULE__, %{})
    subscribe(pid)
    {:ok, pid}
  end

  def handle_frame({type, msg}, state) do
    IO.puts "Received Message - Type: #{inspect type} -- Message: #{inspect msg}"
    {:ok, state}
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
end
