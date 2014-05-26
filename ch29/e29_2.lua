--[[
We can see a boolean array as a set of integers (the indices with true values in the array).  Add to the implementation of boolean arrays functions to compute the union and intersection of two arrays.  These functions should receive two arrays and return a new one, without modifying its parameters.
]]

array = require 'array'

function printarray(a)
  for i = 1, array.size(a) do
    if array.get(a, i) then io.write('1') else io.write('0') end
  end
  print()
end

function testunion()
  local a1 = array.new(10)
  local a2 = array.new(5)

  for i = 1, array.size(a1) do
    array.set(a1, i, i % 2 > 0)
  end

  for i = 1, array.size(a2) do
    array.set(a2, i, i % 2 == 0)
  end

  printarray(a1)
  printarray(a2)
  printarray(array.union(a1, a2))
end

function testintersection()
  local a1 = array.new(10)
  local a2 = array.new(5)

  for i = 1, array.size(a1) do
    array.set(a1, i, i % 2 > 0)
  end

  array.set(a2, 1, true)
  array.set(a2, 2, true)
  array.set(a2, 3, true)

  printarray(a1)
  printarray(a2)
  printarray(array.intersection(a1, a2))
end

testunion()
--[[
1010101010
01010
1111101010
]]

testintersection()
--[[
1010101010
11100
1010000000
]]
