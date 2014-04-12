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
