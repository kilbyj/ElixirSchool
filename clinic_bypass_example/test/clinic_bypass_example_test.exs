defmodule ClinicBypassExampleTest do
  use ExUnit.Case
  doctest ClinicBypassExample

  alias ClinicBypassExample.HealthCheck

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
    end

  test "request with HTTP 200 response", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, "pong")
    end)

    assert {:ok, "pong"} = HealthCheck.ping("http://localhost:#{bypass.port}")
  end

  test "request with HTTP 500 response", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 500, "Server Error")
    end)

    assert {:error, "HTTP Status 500"} = HealthCheck.ping("http://localhost:#{bypass.port}")
  end

  test "request with unexpected outage", %{bypass: bypass} do
    Bypass.down(bypass)

    assert {:error, :econnrefused} = HealthCheck.ping("http://localhost:#{bypass.port}")
  end
end
