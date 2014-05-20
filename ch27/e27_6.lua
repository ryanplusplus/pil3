--[[
Create a C module with all functions from the previous exercises.
]]

module = require 'module'

print(module.summation(2.3, 5.4, -34)) --> -26.3

for k, v in ipairs(module.pack('a', 'b', 'c')) do
  print(k, v)
end
--[[
1 a
2 b
3 c
]]

print(module.reverse(1, "hello", 20)) --> 20 hello 1

module.foreach({x = 10, y = 20, z = 30}, print)
--[[
x 10
y 20
z 30
]]
