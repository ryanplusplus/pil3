--[[
Rewrite function foreach, from the previous exercise, so that the function being called can yield.
]]

foreach = (require 'foreachcont').foreach

co = coroutine.wrap(
  function()
    foreach({x = 10, y = 20, z = 30},
      function(...)
        coroutine.yield()
        print(...)
      end)
  end)

while pcall(co) do end
--[[
z 30
y 20
x 10
]]
