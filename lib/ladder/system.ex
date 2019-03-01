#defmodule Ladder.System do
#  use Supervisor
#
#  def start_link do
#    Supervisor.start_link(
#      [
#        Ladder.ManagerLadder,
#        Ladder.Database.Manager
#      ],
#      strategy: :one_for_one
#    )
#  end
#end


defmodule Ladder.System do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      Ladder.ManagerLadder,
      Ladder.Database.Manager
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

