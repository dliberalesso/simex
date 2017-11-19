defmodule SimEx.Supervisor do
  use Supervisor

  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def start_client(%{} = state) do
    Supervisor.start_child(__MODULE__, [state])
  end

  def init(:ok) do
    spec = Supervisor.child_spec(
      SimEx.Client,
      start: {SimEx.Client, :start_link, []},
      restart: :transient
    )
    
    Supervisor.init([spec], strategy: :simple_one_for_one)
  end
end
