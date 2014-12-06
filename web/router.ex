defmodule Cronweb.Router do
  use Phoenix.Router

  get "/", Cronweb.PageController, :index, as: :pages
  resources "/cronjobs", Cronweb.CronJobController
  #put "/cronjobs/:id"
end
