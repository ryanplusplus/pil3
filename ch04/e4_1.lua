--[[
Most languages with a C-like syntax do not offer an elseif construct.  Why does Lua need this construct more than those languages?
]]

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
