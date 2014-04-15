--[[
Can you explain why Lua has the restriction that a goto cannot jump out of a function?  (Hint: how would you implement that feature?)
]]

--[[
Why can't Lua use goto to jump out of a function?

Jumping out of the stack frame would not allow it to return to the caller.
]]
