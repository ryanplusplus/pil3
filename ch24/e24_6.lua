--[[
Improve the prevvious exercise to handle updates, too.
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

function betterdebug()
  local env = getallvars(2)
  while true do
    io.write("debug> ")
    local line = io.read()
    if line == 'cont' then break end
    assert(load(line, 'debug', 't', env))()
  end
  for k, v in pairs(env) do
    setvarvalue(k, v, 2)
  end
end

x = 3
local y = 4
local _ = (function()
  local z = y + 1
  print('before:', x, y, z)
  betterdebug()
  print('after:', x, y, z)
end)()

--[[
before: 3 4 5
debug> x, y, z = 4, 5, 6
debug> cont
after:  4 5 6
]]
