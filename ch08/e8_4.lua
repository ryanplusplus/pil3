--[[
Can you find any value for f such that the call pcall(pcall, f) returns false as its first result?
]]

f = function() return error end
first = pcall(pcall(f))
print(first) --> false
