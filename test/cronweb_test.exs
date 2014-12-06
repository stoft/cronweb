defmodule CronwebTest do
  use ExUnit.Case

  test "cron parsing" do
    expected = {59, 11..22, [1,9,11], :all, :all}
    actual = Cronweb.CronWrapper.parse_cron_string("59 11-22 1,9,11 * *")
    assert actual == expected
  end

  test "start and stop cron job" do
    {:ok, pid} = Cronweb.CronWrapper.start_cron_job("foo", "* * * * *", "bar")
    IO.inspect pid
    assert is_pid(pid)

    expected = :ok
    actual = Cronweb.CronWrapper.stop_cron_job("foo")
    assert expected == actual
  end
end
