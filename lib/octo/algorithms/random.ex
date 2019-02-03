defmodule Octo.Algorithms.Random do
  @moduledoc """
  Distribution algorithm that returns a random replica.
  """

  @behaviour Octo.Algorithm

  def get_repo(repos), do: Enum.random(repos)
end
