local config = require("lapis.config")
local secrets = require("secrets")

config("development", {
  server = "cqueues",
  port = 8000,
  mysql = {
    host = secrets.mariadb.host,
    port = secrets.mariadb.port,
    user = secrets.mariadb.user,
    password = secrets.mariadb.password,
    database = secrets.mariadb.database
  }
})

config("production", {
  server = "cqueues",
  num_workers = 4,
})