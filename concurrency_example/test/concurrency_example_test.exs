defmodule ConcurrencyExampleTest do
  use ExUnit.Case
  doctest ConcurrencyExample

  test "greets the world" do
    assert ConcurrencyExample.hello() == :world
  end
end
