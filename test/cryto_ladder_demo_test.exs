defmodule CrytoLadderDemoTest do
  use ExUnit.Case
  doctest CrytoLadderDemo

  test "Riki hi elixir world !!!" do
#    assert CrytoLadderDemo.hello() == :world

    Ladder.System.start_link

#    Ladder.Database.Manager.riki_query
#    Ladder.Database.Manager.riki_query4
#    Ladder.Database.Manager.riki_query3

    Process.sleep(50000)
    IO.puts("end websocket binance")
  end

  test "Riki test influxdb" do
#    {:ok, _pid} = Ladder.System.start_link
#    IO.inspect(_pid) # _pid is belong to supervisor

#    Ladder.Database.Manager.riki_cast
#    Ladder.Database.Manager.riki_query


#    Ladder.Database.Abc.ping()
#    |> IO.inspect

#    Process.sleep(50000)
#    IO.puts("end testing influxdb")
  end
end
