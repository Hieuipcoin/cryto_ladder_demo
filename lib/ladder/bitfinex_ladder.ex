defmodule Ladder.BitfinexLadder do
  def start_link do
    children = [
      {Ladder.BitfinexEthBtc, []}
    ]
    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor
    }
  end
end
