--[[
Consider that you have to implement a memorizing table for a function from strings to strings.  Doing the table weak will not allow the removal of entries, because weak tables do not consider strings as collectable objects.  How can you implement memorization in that case?
]]

function size(t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end

--[[
Option 1: Annoy the client by returning a result object that boxes up the string.
]]

local mt = {__mode = "v"}
local foomemo = {}
setmetatable(foomemo, mt)
function foo(string)
  if foomemo[string] then
    return foomemo[string]
  end

  foomemo[string] = {string .. "_"}
  return foomemo[string]
end

foo("hello")
print(size(foomemo)) --> 1

collectgarbage()
print(size(foomemo)) --> 0

--[[
Option 2: Keep a fixed size, circular memo.  This bounds the memo size, but doesn't allow the memo to be collected.
]]
local barmemo = {}
local barmemoregistry = {}
local barmemoindex = 1
local barmemomaxsize = 3
function bar(string)
  if barmemo[string] then
    return foomemo[string]
  end

  if barmemoindex > barmemomaxsize then
    local toremove = barmemoregistry[barmemoindex - barmemomaxsize]
    barmemoregistry[barmemoindex - barmemomaxsize] = nil
    barmemo[toremove] = nil
  end

  barmemo[string] = string .. "_"
  barmemoregistry[barmemoindex] = string
  barmemoindex = barmemoindex + 1

  return barmemo[string]
end

bar("1")
bar("1")
print(size(barmemo)) --> 1

bar("2")
bar("3")
print(size(barmemo)) --> 3

bar("4")
print(size(barmemo)) --> 3

