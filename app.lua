local lapis = require("lapis")
local respond_to = require("lapis.application").respond_to
local db = require("lapis.db")

local app = lapis.Application()

app:enable("etlua")
app.layout = require("views.layout")

app:get("/", function(self)
  -- local users = db.select("select * from users")

  return { render = "home" }
end)


app:match("login", "/login", respond_to({
  GET = function(self)
    return { render = "login" , layout = false}
  end,
  POST = function(self)
    print(self.params.email, self.params.password)
  end
}))


app:match("register", "/register", respond_to({
  GET = function(self)
    return { render = "register" , layout = false}
  end,
  POST = function(self)
    local res = db.insert("users", {
      username = self.params.username,
      email = self.params.email,
      password = self.params.password
    })
    print(res)
  end
}))

return app
