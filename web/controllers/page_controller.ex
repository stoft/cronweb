defmodule Cronweb.PageController do
  use Phoenix.Controller

  def index(conn, _params) do
    cron_jobs = Cronweb.Backend.get
    render conn, "index", [cron_jobs: cron_jobs]
  end

  def not_found(conn, _params) do
    render conn, "not_found"
  end

  def error(conn, _params) do
    render conn, "error"
  end
end
