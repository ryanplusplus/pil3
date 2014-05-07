--[[
Adapt function getvarvalue (Listing 24.1) to work with different coroutines (like other functions from the debug library).
]]

function getvarvalue(co, name, level)
  -- Crappy hack to get around the fact that for some reason the optional argument is first
  if type(co) ~= 'thread' then
    level = name
    name = co
    co = nil
  end

  local value
  local found = false

  if co then
    level = level or 1
  else
    level = (level or 1) + 1
  end

  -- Locals
  for i = 1, math.huge do
    local n, v
    if co then
      n, v = debug.getlocal(co, level, i)
    else
      n, v = debug.getlocal(level, i)
    end
    if not n then break end
    if n == name then
      value = v
      found = true
    end
  end
  if found then return value end

  -- Non-locals
  local func
  if co then
    func = debug.getinfo(co, level, 'f').func
  else
    func = debug.getinfo(level, 'f').func
  end
  for i = 1, math.huge do
    local n, v = debug.getupvalue(func, i)
    if not n then break end
    if n == name then return v end
  end

  -- Look up in environment because we didn't find it
  local env
  if co then
    env = getvarvalue(co, "_ENV", level)
  else
    env = getvarvalue("_ENV", level)
  end
  return env[name]
end

z = 'z'
local x = 'x'
co = coroutine.create(function()
  local a = x
  local y = 'y'
  coroutine.yield()
  coroutine.yield()
end)
coroutine.resume(co)

print(getvarvalue('x', 1)) --> 'x'
print(getvarvalue('z', 1)) --> 'z'

print(getvarvalue(co, 'x', 1)) --> 'x'
print(getvarvalue(co, 'y', 1)) --> 'y'
print(getvarvalue(co, 'z', 1)) --> 'z'
