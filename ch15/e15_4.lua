--[[
What happens if you set a metatable for table package.preload with an __index metamethod?  Can this behavior be useful?
]]

--[[
Since require first checks package.preload, you can use __index to actually preload some modules by forcing the lookup to find a pre-defined module.  Alternately, you could use this trick in an embedded environment where there is no filesystem to load modules from by filling package.preload with a list of pre-defined libraries before starting the Lua VM.
]]
