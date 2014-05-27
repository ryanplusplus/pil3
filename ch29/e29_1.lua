--[[
Modify the implementation of setarray so that it accepts only boolean values.
]]

array = require 'array'

a = array.new(1000)
a:set(1, true)
print(a:get(1)) --> true

a:set(1, 15) --> bad argument #3 to 'set' (boolean expected)
