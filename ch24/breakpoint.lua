breakpoint = {}

local breakpoints = {}

local function hook(type)
  if type == 'return' then
    local info = debug.getinfo(3, 'fn')
    if info == nil then return end -- Bail out if returning from main
    if breakpoints[info.func] then
      debug.sethook(hook, 'clr')
    else
      debug.sethook(hook, 'cr')
    end
  elseif type == 'call' then
    local info = debug.getinfo(2, 'fn')
    if breakpoints[info.func] then
      debug.sethook(hook, 'clr')
    else
      debug.sethook(hook, 'cr')
    end
  elseif type == 'line' then
    local info = debug.getinfo(2, 'fln')
    local fn, line = info.func, info.currentline
    if breakpoints[fn] and breakpoints[fn][line] then
      debug.debug()
    end
  end
end

function breakpoint.set(fn, line)
  breakpoints[fn] = breakpoints[fn] or {}
  breakpoints[fn][line] = true
  return {fn = fn, line = line}
end

function breakpoint.remove(handle)
  breakpoints[handle.fn][handle.line] = nil
  local canremove = true
  for _ in pairs(breakpoints[handle.fn]) do canremove = false end
  if canremove then breakpoints[handle.fn] = {} end
end

debug.sethook(hook, 'cr')

return breakpoint
