--[[
Explain the output of the following program:

local count = 0

local mt = {__gc = function() count = count - 1 end}
local a = {}

for i = 1, 10000 do
  count = count + 1
  a[i] = setmetatable({}, mt)
end

collectgarbage()
print(collectgarbage"count" * 1024, count)
a = nil
collectgarbage()
print(collectgarbage"count" * 1024, count)
collectgarbage()
print(collectgarbage"count" * 1024, count)
]]

local count = 0

local mt = {__gc = function() count = count - 1 end}
local a = {}

for i = 1, 10000 do
  count = count + 1
  a[i] = setmetatable({}, mt)
end

collectgarbage()
print(collectgarbage"count" * 1024, count) --> 925770 10000
a = nil
collectgarbage()
print(collectgarbage"count" * 1024, count) --> 663642 0
collectgarbage()
print(collectgarbage"count" * 1024, count) --> 23562  0

--[[
For the first collection, nothing we're interested in is collected because we haven't released our reference yet.

During the second collection, a is finalized because it is no null.  This leaves each of the 10000 anonymous tables with no incoming references.

After the third collection, all of the anonymous tables are finalized since they have no incoming references.
]]
