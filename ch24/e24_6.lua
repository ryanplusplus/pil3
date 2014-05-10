--[[
Improve the prevvious exercise to handle updates, too.
]]

rdebug = require 'rdebug'

x = 3
local y = 4
local _ = (function()
  local z = y + 1
  print('before:', x, y, z)
  rdebug.betterdebug()
  print('after:', x, y, z)
end)()

--[[
before: 3 4 5
debug> x, y, z = 4, 5, 6
debug> cont
after:  4 5 6
]]
