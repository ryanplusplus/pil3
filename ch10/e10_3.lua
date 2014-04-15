--[[
When we apply the word-frequency program to a text, usually the most frequent words are uninteresting small words like articles and prepositions.  Change the program so that it ignores words with less than four letters.
]]

local function allwords()
  local auxwords = function()
    for line in io.lines() do
      for word in string.gmatch(line, "%w+") do
        coroutine.yield(word)
      end
    end
  end

  return coroutine.wrap(auxwords)
end

local counter = {}
for w in allwords() do
  if #w >= 4 then
    counter[w] = (counter[w] or 0) + 1
  end
end

local words = {}
for w in pairs(counter) do
  words[#words + 1] = w
end

table.sort(words, function(w1, w2)
  return counter[w1] > counter[w2] or (counter[w1] == counter[w2] and w1 < w2)
end)

for i = 1, tonumber(arg[1]) or 10 do
  if words[i] then
    print(words[i], counter[words[i]])
  end
end

--[[
lua e10_3.lua 100 < e10_3.lua
=>
counter 9
words 7
local 4
function 3
allwords 2
auxwords 2
coroutine 2
line 2
return 2
then 2
word 2
gmatch 1
lines 1
pairs 1
print 1
sort 1
string 1
table 1
tonumber 1
wrap 1
yield 1
]]
