o = {x = "finalizer invoked"}
setmetatable(o,  {__gc = function(o) print(o.x) end})
o = nil
os.exit()
