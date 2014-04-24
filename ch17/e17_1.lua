--[[
Write an experiment to determine whether Lua actually implements ephemeron tables.  (Remember to call collectgarbage to force a garbage collection cycle.)  If possible, try your code both in Lua 5.1 and in Lua 5.2 to see the difference.
]]



do
  local mem = {}
  setmetatable(mem, {__mode = "k"})
  function factory(o)
    local res = mem[o]
    if not res then
      res = function() return o end
      mem[o] = res
    end
    return res
  end

  function memsize()
    local count = 0
    for _ in pairs(mem) do
      count = count + 1
    end
    return count
  end
end

factory{}
print(memsize())

collectgarbage()
print(memsize())

--[[
lua e17_1.lua
=>
1
0

luajit e17_1.lua (luajit is kinda sorta lua 5.1)
=>
1
1
]]
