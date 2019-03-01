defmodule CrytoLadderDemo do
  use Application

  def start(_type, _args) do
    Ladder.System.start_link(name: Ladder.System)
  end
end
