defmodule Cronweb.Router do
  use Phoenix.Router

  get "/", Cronweb.PageController, :index, as: :pages
  resources "/cronjob", Cronweb.CronJobController
end
