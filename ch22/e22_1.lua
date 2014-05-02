--[[
Write a program that reads a text file and rewrites it with their lines sorted in alphabetical order.  When called with no arguments, it should read from the standard input file and write to the standard output file.  When called with one file-name argument, it should read from that file and write to the standard output file.  When called with two file-name arguments, it should read from the first file and write to the second one.
]]

from = arg[1] or stdin
to = arg[2] or stdout

io.input(from)
io.output(to)

local lines = {}
for line in io.lines() do
  lines[#lines + 1] = line
end

table.sort(lines)

for _, line in ipairs(lines) do
  io.write(line, '\n')
end

-- lua e22_1.lua < e22_1.lua
--[=[





  io.write(line, '\n')
  lines[#lines + 1] = line
--[[
Write a program that reads a text file and rewrites it with their lines sorted in alphabetical order.  When called with no arguments, it should read from the standard input file and write to the standard output file.  When called with one file-name argument, it should read from that file and write to the standard output file.  When called with two file-name arguments, it should read from the first file and write to the second one.
]]
end
end
for _, line in ipairs(lines) do
for line in io.lines() do
from = arg[1] or stdin
io.input(from)
io.output(to)
local lines = {}
table.sort(lines)
to = arg[2] or stdout
]=]
