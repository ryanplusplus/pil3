--[[
Modify the implementation of the __tostring metamethod so that it shows the full contents of the array in an appropriate way.  Use the buffer facility (Section 28.2) to create the resulting string.
]]

array = require 'array'

a = array.new(10)

a:set(1, true)
a:set(5, true)
a:set(8, true)
a:set(10, true)

print(a) --> 1000100101
