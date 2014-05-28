--[[
Based on the example for boolean arrays, implement a small C library for integer arrays.
]]

integerarray = require 'integerarray'

a = integerarray.new(5)

a:set(1, 6)
a:set(2, 22)
a:set(3, 43)
a:set(4, -14)
a:set(5, -1)

print(a:get(1)) --> 6
print(a:get(2)) --> 22
print(a:get(3)) --> 43
print(a:get(4)) --> -14
print(a:get(5)) --> -1

print(a) --> { 6, 22, 43, -14, -1 }
