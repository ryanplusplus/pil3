--[[
Write an improved version of debug.debug that runs the given commands as if they were in the lexical scope of the calling function.  (Hint: run the commands in an empty environment and use the __index metamethod attached to function getvarvalue to do all accesses to variables.)
]]

rdebug = require 'rdebug'

x = 3
local y = 4
local _ = (function()
  local z = y + 1
  rdebug.betterdebug()
end)()

--[[
debug> print(x)
3
debug> print(y)
4
debug> print(z)
5
debug> cont
]]
