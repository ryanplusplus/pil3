--[[
Describe four different ways to write an unconditional loop in Lua.  Which one do you prefer?
]]

function unconditional_1()
   for i = 0, math.huge do
      io.write(".")
   end
end

function unconditional_2()
   repeat
      io.write(".")
   until(false)
end

function unconditional_3()
   while(true) do
      io.write(".")
   end
end

function unconditional_4()
   ::loop::
   io.write(".")
   goto loop
end

--[[
I prefer while(true) because I'm old school, but not old enough school to want to use goto.
]]
