defmodule Resamplex.Worker do
  @server_path Path.expand("../priv_dir/convert", "#{__DIR__}")

  def start_link([]) do
    :gen_server.start_link(__MODULE__, [], [])
  end

  def init(_state) do
    server_options = %{pty: true, stdin: true, stdout: true, stderr: true}
    {:ok, server_pid, server_os_pid} = Exexec.run_link(@server_path, server_options)
    {:ok, {server_pid, server_os_pid}}
  end

  def handle_call({:resample, fromPath, toWidth, toHeight}, _from, {server_pid, server_os_pid} = state) do
    Exexec.send server_pid, "#{toWidth} #{toHeight} #{fromPath}\n"
    receive do
      {:stderr, ^server_os_pid, message} = _x ->
        {:reply, {:error, String.trim(message)}, state}
      {:stdout, ^server_os_pid, message} = _x ->
        #
        # FIXME: in PTY mode there is no distinction between STDOUT and STDERR
        # and STDOUT does not get picked up if I remove PTY flag from erlexec
        # so this requires further investigation
        #
        # https://github.com/saleyn/erlexec/issues/41
        #
        if String.starts_with?(message, "ERROR") do
          {:reply, {:error, String.trim(message)}, state}
        else
          {:reply, {:ok, String.trim(message)}, state}
        end
    end
  end

  #
  # messages that were not picked up immediately after Exexec.send should be discarded
  # as they are no longer relevant. if they were they would be fed back to the caller
  # which has invoked GenServer.call
  #
  def handle_info({:stdout, _, _}, state), do: {:noreply, state}
  def handle_info({:stderr, _, _}, state), do: {:noreply, state}

  #
  # accept any sort of termination since erlexec does two-way cleanup
  #
  def terminate(_reason, {_server_pid, _server_os_pid} = _state), do: :ok
end
