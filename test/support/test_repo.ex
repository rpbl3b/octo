defmodule Octo.TestRepo do
  use Ecto.Repo,
    otp_app: :octo,
    adapter: Octo.TestAdapter

  def init(type, opts) do
    opts[:parent] && send(opts[:parent], {__MODULE__, type, opts})
    {:ok, opts}
  end
end
