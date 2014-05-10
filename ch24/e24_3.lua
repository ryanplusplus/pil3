--[[
Write a function setvarvalue similar to getvarvalue (Listing 24.1).
]]

rdebug = require 'rdebug'

local x = 3
rdebug.setvarvalue('x', 4)
print(x) --> 4

local f = function()
  local _ = x
  rdebug.setvarvalue('x', 5)
end
f()
print(x) --> 5

y = 3
rdebug.setvarvalue('y', 4)
print(y) --> 4
