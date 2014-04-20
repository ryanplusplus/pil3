--[[
An alternative way to implement read-only tables might use a function as the __index metamethod.  This alternative makes accesses more expensive, but the creation of read-only tables is cheaper, as all read-only tables can share a single metatable.  Rewrite function readOnly using this approach.
]]

local index = {}
local mt = {
  __index = function(t, k) return index[t][k] end,
  __newindex = function(t, k, v)
    error("attempt to update a read-only table", 2)
  end
}

function readOnly(t)
  local proxy = {}
  index[proxy] = t
  setmetatable(proxy, mt)
  return proxy
end

a = readOnly{1, 2, 3, 4}

print(a[1]) --> 1
print(a[3]) --> 3
print(pcall(function() a[1] = 1 end)) --> false e13_4.lua:24: attempt to update a read-only table
