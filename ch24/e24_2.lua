--[[
Adapt function getvarvalue (Listing 24.1) to work with different coroutines (like other functions from the debug library).
]]

local rdebug = require 'rdebug'

z = 'z'
local x = 'x'
co = coroutine.create(function()
  local a = x
  local y = 'y'
  coroutine.yield()
  coroutine.yield()
end)
coroutine.resume(co)

print(rdebug.getvarvalue('x', 1)) --> 'x'
print(rdebug.getvarvalue('z', 1)) --> 'z'

print(rdebug.getvarvalue(co, 'x', 1)) --> 'x'
print(rdebug.getvarvalue(co, 'y', 1)) --> 'y'
print(rdebug.getvarvalue(co, 'z', 1)) --> 'z'
