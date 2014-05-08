--[[
Write an improved version of debug.debug that runs the given commands as if they were in the lexical scope of the calling function.  (Hint: run the commands in an empty environment and use the __index metamethod attached to function getvarvalue to do all accesses to variables.)
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

function betterdebug()
  while true do
    io.write("debug> ")
    local line = io.read()
    if line == 'cont' then break end
    assert(load(line, 'debug', 't', getallvars(2)))()
  end
end

x = 3
local y = 4
local _ = (function()
  local z = y + 1
  betterdebug()
end)()

--[[
debug> print(x)
3
debug> print(y)
4
debug> print(z)
5
debug> cont
]]
