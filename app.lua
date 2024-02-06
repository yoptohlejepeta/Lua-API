local lapis = require("lapis")
local respond_to = require("lapis.application").respond_to
local db = require("lapis.db")

local app = lapis.Application()

app:enable("etlua")
app.layout = require("views.layout")

app:get("/", function(self)
  self.users = db.query("select * from users")

  return { render = "home" }
end)


app:match("login", "/login", respond_to({
  GET = function(self)
    return { render = "login" , layout = false}
  end,
  POST = function(self)
    local user = db.query("select * from users where email = ? and password = ?", self.params.email, self.params.password)
    if user[1] then
      self.session.email = user[1].email
      return self:write("logged in")
    else
      return self:write("invalid username or password")
    end  

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
