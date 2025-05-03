defmodule HapesireTest do
  use ExUnit.Case
  doctest Hapesire

  test "greets the world" do
    assert Hapesire.hello() == :world
  end
end
