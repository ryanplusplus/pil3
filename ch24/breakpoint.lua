breakpoint = {}

local breakpoints = {}

local function hook(type)
  local info
  if type == 'return' then
    info = debug.getinfo(3, 'fl')
    if info == nil then return end -- Bail out if returning from main
  else
    info = debug.getinfo(2, 'fl')
  end
  local fn, line = info.func, info.currentline
  if breakpoints[fn] then
    if breakpoints[fn][line] and type == 'line' then
      debug.debug()
    end
    debug.sethook(hook, 'clr')
  else
    debug.sethook(hook, 'cr')
  end
end

function breakpoint.set(fn, line)
  breakpoints[fn] = breakpoints[fn] or {}
  breakpoints[fn][line] = true
  if fn == debug.getinfo(2, 'f').func then debug.sethook(hook, 'clr') end
  return {fn = fn, line = line}
end

function breakpoint.remove(handle)
  breakpoints[handle.fn][handle.line] = nil
end

debug.sethook(hook, 'clr')

return breakpoint

--[[
This is kind of a mess.
]]
