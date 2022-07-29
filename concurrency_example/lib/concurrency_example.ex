defmodule ConcurrencyExample do
  @moduledoc """
  Documentation for `ConcurrencyExample`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ConcurrencyExample.hello()
      :world

  """
  def hello do
    :world
  end

  def add(a,b) do
    IO.puts(a+b)
  end

  def listen do
    receive do
      {:ok, "hello"} -> IO.puts("World")
    end

    listen()
  end

  def explode, do: exit(:kaboom)

  def run do
    spawn_monitor(ConcurrencyExample, :explode, [])

    receive do
      {:DOWN, _ref, :process, _from_pid, reason} -> IO.puts("Exit Reason: #{reason}")
    end
  end
end
