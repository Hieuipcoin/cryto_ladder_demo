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



defmodule Ladder.BinanceBtcUsdt do
  use WebSockex
  @url "wss://stream.binance.com:9443/ws/btcusdt@trade"

  def start_link(_) do
    IO.puts("riki debug here : Ladder.BinanceBtcUsdt.start_link")
    WebSockex.start_link(@url, __MODULE__, %{})
  end

  def handle_frame({:text, msg}, state) do
    msg
    |> Poison.decode!()
    |> filter()
    |> IO.inspect()
    {:ok, state}
  end

  def handle_cast({:send, {type, msg} = frame}, state) do
    IO.puts("Sending #{type} frame with payload: #{msg}")
    {:reply, frame, state}
  end

  defp filter(decoded_msg) do
    %{"s" => symbol, "p" => price, "q" => quantity} = decoded_msg
    %{"s" => symbol, "p" => price, "q" => quantity}
  end
end
