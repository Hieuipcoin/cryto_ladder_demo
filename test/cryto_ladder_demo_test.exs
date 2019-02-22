defmodule CrytoLadderDemoTest do
  use ExUnit.Case
  doctest CrytoLadderDemo

  test "Riki hi elixir world !!!" do
#    assert CrytoLadderDemo.hello() == :world

    Ladder.System.start_link

    Process.sleep(50000)
    IO.puts("end websocket binance")
  end
end
