defmodule OtpConcurrencyGenserverTest do
  use ExUnit.Case
  doctest OtpConcurrencyGenserver

  test "greets the world" do
    assert OtpConcurrencyGenserver.hello() == :world
  end
end
