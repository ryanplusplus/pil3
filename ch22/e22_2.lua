--[[
Change the previous program so that it asks for a confirmation if the user gives the name of an existing file for its output.
]]

if arg[2] then
  f = io.open(arg[2], 'r')
  if f then
    print('The file \'' .. arg[2] .. '\' already exists.  Press enter to continue, ctrl+c to abort.')
    io.read()
    io.close(f)
  end
end

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
