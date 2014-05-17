--[[
Implement a function equivalent to table.pack, from the standard library.
]]

pack = (require 'pack').pack

for k, v in ipairs(pack('a', 'b', 'c')) do
  print(k, v)
end

--[[
1 a
2 b
3 c
]]
