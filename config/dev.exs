use Mix.Config

config :phoenix, Cronweb.Router,
  port: System.get_env("PORT") || 4000,
  ssl: false,
  host: "localhost",
  cookies: true,
  session_key: "_cronweb_key",
  session_secret: "T66S3(G*1SYT9Z@B!6$EF41U00X7&KTY4N)6#N96@7VK15@M5&K4GN*%VKOGZ(Z(Q92+LV+78OG",
  debug_errors: true

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


