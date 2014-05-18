--[[
Write a function foreach that receives a table and a function and calls that function for each pair key-value in the table.

foreach({x = 10, y = 20}, print)
--> x 10
--> y 20

(Hint: check function lua_next in the Lua manual.)
]]

foreach = (require 'foreach').foreach

foreach({x = 10, y = 20, z = 30}, print)
--[[
z 30
y 20
x 10
]]
