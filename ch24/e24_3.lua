--[[
Write a function setvarvalue similar to getvarvalue (Listing 24.1).
]]

function getvarvalue(name, level)
  local value
  local found = false

  level = (level or 1) + 1

  -- Locals
  for i = 1, math.huge do
    local n, v = debug.getlocal(level, i)
    if not n then break end
    if n == name then
      value = v
      found = true
    end
  end
  if found then return value end

  -- Non-locals
  local func = debug.getinfo(level, 'f').func
  for i = 1, math.huge do
    local n, v = debug.getupvalue(func, i)
    if not n then break end
    if n == name then return v end
  end

  -- Look up in environment because we didn't find it
  local env = getvarvalue('_ENV', level)
  return env[name]
end

function setvarvalue(name, value, level)
  level = (level or 1) + 1

  -- Locals
  for i = 1, math.huge do
    local n, v = debug.getlocal(level, i)
    if not n then break end
    if n == name then
      debug.setlocal(level, i, value)
      return
    end
  end

  -- Non-locals
  local func = debug.getinfo(level, 'f').func
  for i = 1, math.huge do
    local n, v = debug.getupvalue(func, i)
    if not n then break end
    if n == name then
      debug.setupvalue(func, i, value)
      return
    end
  end

  -- Look up in environment because we didn't find it
  local env = getvarvalue('_ENV', level)
  env[name] = value
end

local x = 3
setvarvalue('x', 4)
print(x) --> 4

local f = function()
  local _ = x
  setvarvalue('x', 5)
end
f()
print(x) --> 5

y = 3
setvarvalue('y', 4)
print(y) --> 4
