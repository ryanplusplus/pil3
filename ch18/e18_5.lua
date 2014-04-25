--[[
Write a function to shuffle a given list.  Make sure that all permutations are equally probable.
]]

-- Given that only an array-like table has an 'order', I've assumed that's what I'm going to get.
function shuffle(l)
  local keys = {}

  for i = 0, #l do
    keys[i] = i
  end

  local shuffled = {}
  while #keys > 0 do
    i = table.remove(keys, math.random(#keys))
    shuffled[#shuffled + 1] = l[i]
  end

  return shuffled
end

print(table.unpack(shuffle{1,2,3,4,5})) --> 5 2 4 3 1
print(table.unpack(shuffle{1,2,3,4,5})) --> 1 3 5 2 4
print(table.unpack(shuffle{1,2,3,4,5})) --> 3 4 2 5 1

-- Just to get a little confidence that it is actually uniform
res = {}
for _ = 1, 100000 do
  s = table.concat(shuffle{1,2,3})
  res[s] = (res[s] or 0) + 1
end

for _, v in pairs(res) do
  print(v)
end
--[[
16797
16390
16731
16766
16925
16391
]]
