local lapis = require("lapis")
local respond_to = require("lapis.application").respond_to
local db = require("lapis.db")

local app = lapis.Application()

app:enable("etlua")
app.layout = require("views.layout")

app:get("home" ,"/", function(self)
  if not self.session.user then
    return {redirect_to = self:url_for("login")}
  end

  print(self.session.user)
  self.users = db.query("select * from users")

  return { render = "home" }
end)


app:get("logout", "/logout", function(self)
  self.session.user = nil
  return {redirect_to = self:url_for("login")}
end)


app:match("login", "/login", respond_to({
  GET = function(self)
    return { render = "login" , layout = false}
  end,
  POST = function(self)
    local user = db.query("select * from users where email = ? and password = ?", self.params.email, self.params.password)
    if user[1] then
      self.session.user = user
      return {redirect_to = self:url_for("home")}
    end

    self.error = "Invalid email or password"

    return {layout = false, render = "login"}
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
    
    if res then 
      return {redirect_to = self:url_for("login")}
    else
      return {layout = false, render = "register"}
    end
  end
}))

return app
