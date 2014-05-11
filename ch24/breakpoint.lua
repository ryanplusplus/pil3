breakpoint = {}

local breakpoints = {}

local function hook()
  local info = debug.getinfo(2, 'fl')
  local fn, line = info.func, info.currentline
  if breakpoints[fn] and breakpoints[fn][line] then
    debug.debug()
  end
end

function breakpoint.set(fn, line)
  breakpoints[fn] = breakpoints[fn] or {}
  breakpoints[fn][line] = true
  return {fn = fn, line = line}
end

function breakpoint.remove(handle)
  breakpoints[handle.fn][handle.line] = nil
end

debug.sethook(hook, 'l')

return breakpoint
