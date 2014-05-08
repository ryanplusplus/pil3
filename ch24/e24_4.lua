--[[
Write a modification of getvarvalue (Listing 24.1), called getallvars, that returns a table with all variables that are visible at the calling function.  (The returned table should not include environmental variables; instead, it should inherit them from the original environment.)
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

function getallvars(level)
  local vars = {}

  level = (level or 1) + 1

  -- Non-locals (do these first so that locals have priority)
  local func = debug.getinfo(level, 'f').func
  for i = 1, math.huge do
    local n, v = debug.getupvalue(func, i)
    if not n then break end
    vars[n] = v
  end

  -- Locals
  for i = 1, math.huge do
    local n, v = debug.getlocal(level, i)
    if not n then break end
    vars[n] = v
  end

  -- Look up in environment and use it as __index
  setmetatable(vars, {__index = getvarvalue('_ENV', level)})

  return vars
end

x = 3
local y = 4
local _ = (function()
  local z = y + 1
  local vars = getallvars()
  -- Global, from meteatable
  print(vars.x) --> 3

  -- Upvalue
  print(vars.y) --> 4

  -- Local
  print(vars.z) --> 5

  -- Global, via upvalue _ENV
  print(vars._ENV.x) --> 3
end)()
