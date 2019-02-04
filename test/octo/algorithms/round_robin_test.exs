defmodule Octo.Algorithms.RoundRobinTest do
  use ExUnit.Case
  alias Octo.Algorithms.RoundRobin

  describe "get_repo/1" do
    test "returns repos in round robin fashion" do
      repos = [:foo, :bar, :baz, :bat]

      assert :foo == RoundRobin.get_repo(repos)
      assert :bar == RoundRobin.get_repo(repos)
      assert :baz == RoundRobin.get_repo(repos)
      assert :bat == RoundRobin.get_repo(repos)
      assert :foo == RoundRobin.get_repo(repos)
    end
  end
end
