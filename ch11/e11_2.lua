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

local ignoredwords = {}
if #arg >= 2 then
  -- Use a file instead of stdin for ignored words
  io.input(arg[2])

  for word in allwords() do
    ignoredwords[word] = true
  end
end

-- Hook stdin back up
io.input(io.stdin)

local counter = {}
for w in allwords() do
  if ignoredwords[w] == nil then
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
lua e11_2.lua 100 e11_2.lua < e11_2.lua
=>
<empty -- all words were ignored!>
]]

--[[
lua e11_2.lua 100 e11_1.lua < e11_2.lua
=>
counter 10
words 10
lua 7
w 7
in  5
word  5
allwords  4
io  4
w1  4
w2  4
arg 3
auxwords  3
coroutine 3
e11 3
ignoredwords  3
line  3
or  3
stdin 3
100 2
e10 2
gmatch  2
ignored 2
input 2
lines 2
pairs 2
sort  2
string  2
tonumber  2
wrap  2
yield 2
10  1
4 1
7 1
9 1
Hook  1
Use 1
a 1
all 1
and 1
back  1
because 1
file  1
instead 1
of  1
true  1
up  1
were  1
]]
