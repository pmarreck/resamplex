defmodule Resamplex.Pool do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    supervise([
      :poolboy.child_spec(:resamplex_pool, pool_config())
    ], strategy: :one_for_one, name: __MODULE__)
  end

  def request(fromPath, toWidth, toHeight) do
    :poolboy.transaction(:resamplex_pool, fn (worker) ->
      try do
        GenServer.call(worker, {:resample, fromPath, toWidth, toHeight}, 100000) # fixme: timeout should be configurable and exposed
      catch :exit, reason ->
        Process.exit(worker, :kill)
        case reason do
          {:timeout, _} -> {:error, :timeout}
          _ -> {:error, :unknown}
        end
      end
    end)
  end

  defp pool_config() do
    [
      name: {:local, :resamplex_pool},
      worker_module: Resamplex.Worker,
      size: 1,
      max_overflow: 4
    ]
  end
end