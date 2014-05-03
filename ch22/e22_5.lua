--[[
Generalize the previous program so that it prints the last n lines of a text file.  Again, try to avoid reading the entire file when the file is large and seekable.
]]

if not tonumber(arg[1]) then
  error('Need to provide a number as the first argument!')
end

if not arg[2] then
  error('Need to provide a file as the second argument!')
end

local linecount = tonumber(arg[1])
local f = io.open(arg[2])
local len = f:seek('end')
local offset = 2
local lines = {}
while #lines < linecount do
  if offset > len then
    f:seek('set')
    lines[#lines + 1] = f:read()
    break
  else
    f:seek('end', -offset)
    if f:read(1) == '\n' then
      lines[#lines + 1] = f:read()
    end
    offset = offset + 1
  end
end

for i = #lines, 1, -1 do
  print(lines[i])
end

--[[
lua e22_5.lua 2 multiplelines
-->
line 3
last line
]]

--[[
lua e22_5.lua 3 multiplelines
-->
line 2
line 3
last line
]]

--[[
lua e22_5.lua 3 oneline
-->
only one line
]]
