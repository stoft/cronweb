# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Cronweb.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_cronweb_key",
  session_secret: "T66S3(G*1SYT9Z@B!6$EF41U00X7&KTY4N)6#N96@7VK15@M5&K4GN*%VKOGZ(Z(Q92+LV+78OG",
  catch_errors: true,
  debug_errors: false,
  error_controller: Cronweb.PageController

config :phoenix, :code_reloader,
  enabled: false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
