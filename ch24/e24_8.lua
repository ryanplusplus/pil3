--[[
Write a library for breakpoints.  It should offer at least two functions:

setbreakpoint(function, line) --> returns handle
removebreakpoint(handle)

A breakpoint is specified by a function and a line inside that function. When
the program hits a breakpoint, the library should call debug.debug.  (Hint: for a
basic implementation, use a line hook that checks whether it is in a breakpoint;
to improve performance, use a call hook to trace the program execution and only
turn the line hook when the program is running the target function.)
]]

breakpoint = require 'breakpoint'

local function f()
  print('before breakpoint in f')
  print('breakpoint in f')
end

local bp1 = breakpoint.set(debug.getinfo(1, 'f').func, 25) --> breakpoint in main
local bp2 = breakpoint.set(f, 18) --> breakpoint in a function

print('before breakpoint at f')
f()

breakpoint.remove(bp1)
breakpoint.remove(bp2)
print('breakpoints removed')

f()

--[[
lua e24_8.lua
-->
before breakpoint at f
lua_debug> cont
before breakpoint in f
lua_debug> cont
breakpoint in f
breakpoints removed
before breakpoint in f
breakpoint in f
]]
