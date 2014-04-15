--[[
Write a function that receives an array and prints all combinations of the elements in the array.  (Hint: you can use the recursive formula for combination: C(n, m) = C(n - 1, m - 1) + C(n - 1, m).  To generate all C(n, m) combinations of n elements in groups of size m, you first add the element to the result and then generate all C(n - 1, m - 1) combinations of the remaining elements in the remaining slots; then you remove the first element from the result and then generate all C(n - 1, m) combinations of the remaining elements in the free slots.  When n is smaller than m, there are no combinations.  When m is zero, there is only one combination, which uses no elements.)
]]

function rest(list)
  return (function(head, ...) return table.pack(...) end)(unpack(list))
end

function combinations(a, m)
  local tail = rest(a)
  local result = {}

  if m > #a then return {} end
  if m == 0 then return {{}} end

  for _, v in pairs(combinations(tail, m - 1)) do
    table.insert(v, 1, a[1])
    result[#result + 1] = v
  end

  for _, v in pairs(combinations(tail, m)) do
    result[#result + 1] = v
  end

  return result
end

for _, v in ipairs(combinations({1,2,3,4,5,6,7}, 5)) do
  print(unpack(v))
end

--[[
1 2 3 4 5
1 2 3 4 6
1 2 3 4 7
1 2 3 5 6
1 2 3 5 7
1 2 3 6 7
1 2 4 5 6
1 2 4 5 7
1 2 4 6 7
1 2 5 6 7
1 3 4 5 6
1 3 4 5 7
1 3 4 6 7
1 3 5 6 7
1 4 5 6 7
2 3 4 5 6
2 3 4 5 7
2 3 4 6 7
2 3 5 6 7
2 4 5 6 7
3 4 5 6 7
]]
