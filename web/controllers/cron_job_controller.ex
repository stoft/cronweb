defmodule Cronweb.CronJobController do
  use Phoenix.Controller
  
  alias Cronweb.Router
  alias Cronweb.CronJob
  alias Cronweb.Backend

  def index(conn, _params) do
    redirect conn, Router.Helpers.pages_path(:index)
  end

  def new(conn, _params) do
    render conn, "new"
  end

  def create(conn, params) do
    cron_job = %CronJob{name: params["name"], 
          description: params["description"],
              command: params["command"],
              cron_schedule: params["cron_schedule"] }
    Backend.insert(cron_job, "id")
    redirect conn, Router.Helpers.pages_path(:index)
  end

  def show(conn, params) do
    IO.inspect params
    cron_job = Backend.get(params["id"])
    render conn, "cron_job", cron_job: cron_job, action: params["action"]
  end
  
  def edit(conn, params) do
    cron_job = Backend.get(params["id"])
    render conn, "edit", cron_job: cron_job
  end

  def update(conn, params) do
    #IO.inspect
    params = Dict.delete(params, "_method")
    cron_job = %CronJob{}
    cron_job = %{cron_job | name: params["name"],
        description: params["description"],
        command: params["command"],
        cron_schedule: params["cron_schedule"],
        id: params["id"],
        version: String.to_integer(params["version"])}

    #IO.inspect job

    Backend.update(cron_job, params["id"])
    
    redirect conn, Router.Helpers.pages_path(:index)
  end
  
  def destroy(conn, params) do
    Backend.delete(params["id"])
    redirect conn, Router.Helpers.pages_path(:index)
  end
end