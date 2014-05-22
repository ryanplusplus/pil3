--[[
Implement a filter function in C.  It should receive a list and a predicate and return a new list with all elements from the given list that satisfy the predicate:

t = filter({1, 3, 20, -4, 5}, function(x) return x < 5 end)
-- t = {1, 3, -4}

(A predicate is just a function that tests some condition, returning a boolean.)
]]

filter = (require 'filter').filter

print(unpack(filter({1, 3, 20, -4, 5}, function(x) return x < 5 end))) --> 1 3 -4
