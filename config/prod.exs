use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Cronweb.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_cronweb_key",
  session_secret: "T66S3(G*1SYT9Z@B!6$EF41U00X7&KTY4N)6#N96@7VK15@M5&K4GN*%VKOGZ(Z(Q92+LV+78OG"

config :logger, :console,
  level: :info,
  metadata: [:request_id]

