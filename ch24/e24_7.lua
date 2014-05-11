--[[
Implement some of the suggested improvements for the basic profiler in Section 24.3.
]]

local Counters = {}
local Names = {}

local function hook()
  local f = debug.getinfo(2, 'f').func
  local count = Counters[f]
  if count == nil then
    Counters[f] = 1
    Names[f] = debug.getinfo(2, 'Sn')
  else
    Counters[f] = count + 1
  end
end

local f = assert(loadfile(arg[1]))
debug.sethook(hook, 'c')
f()
debug.sethook()

function getname(func)
  local n = Names[func]
  if n.what == 'C' then
    return tostring(n.name)
  end
  local lc = string.format('[%s]:%d', n.short_src, n.linedefined)
  if n.what ~= 'main' and n.namewhat ~= '' then
    return string.format('%s (%s)', lc, n.name)
  else
    return lc
  end
end

local functionheader = '[[Function]]'
local countheader = '[[Count]]'

output = {}
longest = #functionheader
for func, count in pairs(Counters) do
  local line = {name = getname(func), count = count}
  if #line.name > longest then longest = #line.name end
  output[#output + 1] = line
end

-- Sort by call count
table.sort(output, function(x, y) return y.count < x.count end)

print(functionheader .. string.rep(' ', longest + 1 - #functionheader) .. countheader)

-- Print with call counts aligned
for _, line in pairs(output) do
  print(line.name .. string.rep(' ', longest + 1 - #line.name) .. line.count)
end
