--[[
Modify the implementation of setarray so that it accepts only boolean values.
]]

array = require 'array'

a = array.new(1000)
array.set(a, 1, true)
print(array.get(a, 1)) --> true

array.set(a, 1, 15) --> bad argument #3 to 'set' (boolean expected)
