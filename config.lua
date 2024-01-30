local config = require("lapis.config")

config("development", {
  server = "cqueues",
  port = 8000,
})

config("production", {
  server = "cqueues",
  num_workers = 4,
})