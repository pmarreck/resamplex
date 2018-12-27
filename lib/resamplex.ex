defmodule Resamplex do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Resamplex.Pool, []),
    ]

    opts = [strategy: :one_for_one, name: Resamplex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def request(fromPath, toWidth, toHeight) do
    Resamplex.Pool.request(fromPath, toWidth, toHeight)
  end
end
