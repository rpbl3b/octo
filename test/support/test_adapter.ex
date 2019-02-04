defmodule Octo.TestAdapter do
  @moduledoc """
  Minimal Ecto.Adapter implementation used for testing.
  """

  @behaviour Ecto.Adapter

  defmacro __before_compile__(_env), do: :ok

  def checkout(_adapter_meta, _options, _function), do: :ok

  def dumpers(:binary_id, type), do: [type, Ecto.UUID]
  def dumpers(_primitive, type), do: [type]

  def ensure_all_started(_config, _type), do: {:ok, []}

  # TODO: this may require a child_spec
  def init(_config), do: {:ok, child_spec(), %{}}

  def child_spec do
    Supervisor.Spec.worker(Task, [fn -> :timer.sleep(:infinity) end])
  end

  def loaders(:binary_id, type), do: [Ecto.UUID, type]
  def loaders(_primitive, type), do: [type]
end
