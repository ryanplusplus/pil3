--[[
In Lua, all ifs must be terminated with an 'end'.  Without elseif you'd need to write:

if cond1 then
...
else if cond2 then
...
else if cond3 then
...
end end end

Using elseif allows the (ugly) list of 'end's to be avoided.
]]
