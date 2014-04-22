--[[
Rewrite the code in Listing 13.1 as a proper module.
]]

Set = require "Set"

print(Set.new{1, 2, 3, 4} + Set.new{3, 4, 5, 6}) --> {1, 2, 3, 4, 5, 6}
print(Set.new{1, 2, 3, 4} - Set.new{3, 4, 5, 6}) --> {1, 2}
