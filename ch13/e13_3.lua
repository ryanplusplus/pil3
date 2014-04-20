--[[
Complete the implementation of proxies in Section 13.4 with an __ipairs metamethod.
]]

-- t = {}

-- local _t = t

-- t = {}

local index = {}

local mt = {
  __index = function(t, k)
    print("*access to element " .. tostring(k))
    return t[index][k]
  end,

  __newindex = function(t, k, v)
    print("*update of element " .. tostring(k) .. " to " .. tostring(v))
    t[index][k] = v
  end,

  __pairs = function(t)
    return function (_, k)
      return next(t[index], k)
    end
  end,

  __ipairs = function(t)
    local i = 0
    return function()
      i = i + 1
      if t[index][i] then
        return i, t[index][i]
      end
    end
  end
}

function track(t)
  local proxy = {}
  proxy[index] = t
  setmetatable(proxy, mt)
  return proxy
end

local a = {"first", "second", "third", [5] = "stranded"}
local proxy = track(a)

for k, v in pairs(proxy) do
  print(k, v)
end
--[[
1 first
2 second
3 third
5 stranded
]]

for i, v in ipairs(proxy) do
  print(i, v)
end
--[[
1 first
2 second
3 third
]]
