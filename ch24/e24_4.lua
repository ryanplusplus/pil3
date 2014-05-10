--[[
Write a modification of getvarvalue (Listing 24.1), called getallvars, that returns a table with all variables that are visible at the calling function.  (The returned table should not include environmental variables; instead, it should inherit them from the original environment.)
]]

rdebug = require 'rdebug'

x = 3
local y = 4
local _ = (function()
  local z = y + 1
  local vars = rdebug.getallvars()
  -- Global, from meteatable
  print(vars.x) --> 3

  -- Upvalue
  print(vars.y) --> 4

  -- Local
  print(vars.z) --> 5

  -- Global, via upvalue _ENV
  print(vars._ENV.x) --> 3
end)()
