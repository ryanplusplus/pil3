--[[
Write a program that prints the last line of a text file.  Try to avoid reading the entire file when the file is large and seekable.
]]

if not arg[1] then
  error('Need to provide a file!')
end

local f = io.open(arg[1])
local len = f:seek('end')
local offset = 2
while true do
  if offset > len then
    f:seek('set')
    print(f:read())
    break
  else
    f:seek('end', -offset)
    if f:read(1) == '\n' then
      print(f:read())
      break
    end
    offset = offset + 1
  end
end

--[[
lua e22_4.lua oneline  --> only one line
lua e22_4.lua multiplelines --> last line
]]
