package = "lua-api"
version = "dev-1"
source = {
   url = "https://github.com/yoptohlejepeta/Lua-API"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
dependencies = {
   "lua >= 5.1",
   "http",
   "cqueues",
   "lapis"
}
build = {
   type = "builtin",
   modules = {
      main = "main.lua"
   }
}
