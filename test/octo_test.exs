defmodule OctoTest do
  use ExUnit.Case
  doctest Octo

  test "greets the world" do
    assert Octo.hello() == :world
  end
end
