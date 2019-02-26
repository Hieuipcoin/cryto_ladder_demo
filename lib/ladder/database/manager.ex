defmodule Ladder.Database.Manager do
  use Instream.Connection, otp_app: :cryto_ladder_demo
#  use GenServer



  # for testing only
  def riki_query do
    Ladder.Database.Manager.status()
    |> IO.inspect
  end

  # for testing only
  def riki_query2 do
    IO.puts("riki begin query influxdb")
    "SELECT * FROM price"
    |> Ladder.Database.Manager.query(database: "riki_test")
    |> IO.inspect
    IO.puts("riki end query influxdb")
  end

  # for testing only
  def riki_query3 do
    "SELECT * FROM price"
    |> Ladder.Database.Manager.query
    |> LadderSeries.from_result()
    |> IO.inspect
  end

  # for testing only
  def riki_query4 do
    data = %LadderSeries{}
    data = %{data | fields: %{data.fields | value: 17.7}}
    data = %{data | tags: %{data.tags | exchange: "binance", symbol: "btcusdt"}}

    # write the point asynchronously
    Ladder.Database.Manager.write(data)
    |> IO.inspect
  end

#  @impl true
#  def init(_) do
#    IO.puts("#{__MODULE__} from init")
#
#    Ladder.Database.Manager.status()
#    |> IO.inspect
#
#
#    {:ok, "from init"}
#  end
#
#  def riki_query() do
#    GenServer.call(__MODULE__, :query)
#  end
#
#  def riki_cast() do
#    GenServer.cast(__MODULE__, {:riki_cast, "from cast"})
#  end
#
#  @impl GenServer
#  def handle_cast({:riki_cast, string_cast}, _state) do
#    IO.puts("riki handle cast: #{string_cast}")
#    {:noreply, ""}
#  end
#
##  def child_spec(_) do
##    %{
##      id: __MODULE__,
##      start: {__MODULE__, :start_link, []},
##      type: :worker
##    }
##  end
#
#  def start_link() do
#    IO.puts("#{__MODULE__} start_link")
##    {:ok, pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
#    GenServer.start_link(__MODULE__, [], name: __MODULE__)
#    |> IO.inspect
#  end
#
#
#  @impl GenServer
#  def handle_call(:query, _, state) do
#
#    IO.puts("riki begin query influxdb")
#    "SELECT * FROM price"
#    |> Ladder.Database.Manager.query(database: "riki_test")
#    |> IO.inspect
#    IO.puts("riki end query influxdb")
#
#    {
#      :reply,
#      "ping",
#      state
#    }
#  end
end

