defmodule Octo.Algorithm do
  @moduledoc """
  Algorithms are strategies for distributing reads across Ecto.Repos.
  """

  @callback get_repo([Ecto.Repo.t()]) :: Ecto.Repo.t()
end
