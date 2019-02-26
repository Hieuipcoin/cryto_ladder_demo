defmodule Ladder.ManagerLadder do
  def start_link do
    children = [
      {Ladder.BinanceLadder, []}
#      {Ladder.BitfinexLadder, []}
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor
    }
  end
end
