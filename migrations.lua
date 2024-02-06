local schema = require("lapis.db.schema")
local types = schema.types

schema.create_table("users", {
  { "id", types.id },
  { "username", types.varchar },
  { "email", types.varchar},
  { "password", types.varchar },
})