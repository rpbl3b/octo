defmodule Octo.Algorithms.RoundRobin do
  @moduledoc """
  RoundRobin implementation for selecting replica repo.
  """

  @behaviour Octo.Algorithm

  defmodule Queue do
    use Agent

    def start_link(repos) do
      Agent.start_link(fn -> :queue.from_list(repos) end, name: __MODULE__)
    end

    def get_repo do
      Agent.get_and_update(__MODULE__, fn repos ->
        {{:value, repo}, rst} = :queue.out(repos)
        {repo, :queue.in(repo, rst)}
      end)
    end
  end

  def get_repo(repos) do
    # Will return {:error, {:already_started, pid}} if agent already exists.
    Queue.start_link(repos)
    Queue.get_repo()
  end
end
