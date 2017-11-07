defmodule SimExTest do
  use ExUnit.Case
  doctest SimEx

  test "greets the world" do
    assert SimEx.hello() == :world
  end
end
