--[[
Define a metamethod __len for sets so that #s returns the number of elements in set s.
]]

Set = {}
local mt = {}

function Set.new(l)
  local set = {}
  setmetatable(set, mt)
  for _, v in ipairs(l) do set[v] = true end
  return set
end

function Set.union(a, b)
  local res = Set.new{}
  for k in pairs(a) do res[k] = true end
  for k in pairs(b) do res[k] = true end
  return res
end

function Set.intersection(a, b)
  local res = Set.new{}
  for k in pairs(a) do
    res[k] = b[k]
  end
  return res
end

function Set.tostring(set)
  local l = {}
  for e in pairs(set) do
    l[#l + 1] = e
  end
  return "{" .. table.concat(l, ", ") .. "}"
end

function Set.difference(a, b)
  local res = Set.new{}
  for k in pairs(a) do
    if b[k] == nil then
      res[k] = a[k]
    end
  end
  return res
end

function Set.print(set)
  print(Set.tostring(set))
end

function Set.length(set)
  local len = 0
  for e in pairs(set) do
    len = len + 1
  end
  return len
end


mt.__tostring = Set.tostring
mt.__add = Set.union
mt.__sub = Set.difference
mt.__mul = Set.intersection
mt.__len = Set.length

mt.__le = function(a, b)
  for k in pairs(a) do
    if not b[k] then return false end
  end
  return true
end

mt.__lt = function(a, b)
  return a <= b and not (b <= a)
end

mt.__eq = function(a, b)
  return a <= b and b <= a
end

print(#(Set.new{1, 2, 3, 4})) --> 4
print(#(Set.new{7, 8, 9})) --> 3
