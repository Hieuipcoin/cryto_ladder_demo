defmodule Ladder.System do
  def start_link do
    Supervisor.start_link(
      [
        Ladder.ManagerLadder,
        Ladder.Database.Manager
      ],
      strategy: :one_for_one
    )
  end
end
