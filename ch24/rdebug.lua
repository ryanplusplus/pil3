local mt = { __index = debug }
local rdebug = {}
setmetatable(rdebug, mt)

function rdebug.getvarvalue(co, name, level)
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
      n, v = rdebug.getlocal(co, level, i)
    else
      n, v = rdebug.getlocal(level, i)
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
    func = rdebug.getinfo(co, level, 'f').func
  else
    func = rdebug.getinfo(level, 'f').func
  end
  for i = 1, math.huge do
    local n, v = rdebug.getupvalue(func, i)
    if not n then break end
    if n == name then return v end
  end

  -- Look up in environment because we didn't find it
  local env
  if co then
    env = rdebug.getvarvalue(co, "_ENV", level)
  else
    env = rdebug.getvarvalue("_ENV", level)
  end
  return env[name]
end

function rdebug.setvarvalue(name, value, level)
  level = (level or 1) + 1

  -- Locals
  for i = 1, math.huge do
    local n, v = rdebug.getlocal(level, i)
    if not n then break end
    if n == name then
      rdebug.setlocal(level, i, value)
      return
    end
  end

  -- Non-locals
  local func = rdebug.getinfo(level, 'f').func
  for i = 1, math.huge do
    local n, v = rdebug.getupvalue(func, i)
    if not n then break end
    if n == name then
      rdebug.setupvalue(func, i, value)
      return
    end
  end

  -- Look up in environment because we didn't find it
  local env = rdebug.getvarvalue('_ENV', level)
  env[name] = value
end

function rdebug.getallvars(level)
  local vars = {}

  level = (level or 1) + 1

  -- Non-locals (do these first so that locals have priority)
  local func = rdebug.getinfo(level, 'f').func
  for i = 1, math.huge do
    local n, v = rdebug.getupvalue(func, i)
    if not n then break end
    vars[n] = v
  end

  -- Locals
  for i = 1, math.huge do
    local n, v = rdebug.getlocal(level, i)
    if not n then break end
    vars[n] = v
  end

  -- Look up in environment and use it as __index
  setmetatable(vars, {__index = rdebug.getvarvalue('_ENV', level)})

  return vars
end

function rdebug.debug()
  local env = rdebug.getallvars(2)
  while true do
    io.write("rdebug> ")
    local line = io.read()
    if line == 'cont' then break end
    assert(load(line, 'rdebug', 't', env))()
  end
  for k, v in pairs(env) do
    rdebug.setvarvalue(k, v, 2)
  end
end

return rdebug
