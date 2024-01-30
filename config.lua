local config = require("lapis.config")

config("development", {
  server = "cqueues",
  port = 8081,
})

config("production", {
  server = "cqueues",
  num_workers = 4,
})