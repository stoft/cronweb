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
    IO.puts "in edit"
    id = params["id"]
    cron_job = Backend.get(id)
    active = String.to_existing_atom(params["active"])
    IO.puts "active is #{active}, db is #{cron_job.active}"
    if (active != cron_job.active) do
      IO.puts "in if"
      cron_job = %{cron_job | active: active}
      Backend.update(cron_job, id)
      result = toggle_cron_job(cron_job, active)
      case result do
        :ok -> :ok
        _ ->
          cron_job = %{cron_job | active: not active}
          Backend.update(cron_job, id)
          IO.puts "cron toggle failed with #{to_string(elem(result, 1))}"
      end
      redirect conn, Router.Helpers.pages_path(:index)
    else
      render conn, "edit", cron_job: cron_job
    end
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
        version: String.to_integer(params["version"]),
        active: String.to_existing_atom(params["active"])
      }

    Backend.update(cron_job, params["id"])
    
    redirect conn, Router.Helpers.pages_path(:index)
  end
  
  def destroy(conn, params) do
    Backend.delete(params["id"])
    redirect conn, Router.Helpers.pages_path(:index)
  end

  defp toggle_cron_job(cron_job, false) do
    Cronweb.CronWrapper.stop_cron_job(cron_job.id)
  end

  defp toggle_cron_job(cron_job, true) do
    #IO.puts "inside toggle_cron_job false"
    result = Cronweb.CronWrapper.start_cron_job(cron_job.id,
      cron_job.cron_schedule,
      cron_job.command)
    case result do
      {:ok, _pid} -> :ok
      _ -> result
    end
  end
end