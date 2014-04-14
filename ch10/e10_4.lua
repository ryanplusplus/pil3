function allwords()
  local line = io.read()
  local pos = 1

  return function()
    while line do
      local s, e = string.find(line, "%w+", pos)

      if s then
        pos = e + 1
        return string.sub(line, s, e)
      else
        line = io.read()
        pos = 1
      end
    end

    return nil
  end
end

function prefix(c)
  return table.concat(c, " ")
end

local statetab = {}

function insert(index, value)
  local list = statetab[index]

  if list == nil then
    statetab[index] = {value}
  else
    list[#list + 1] = value
  end
end

local N = tonumber(arg[1]) or 2
local MAXGEN = 10000
local NOWORD = "\n"

function initializetab(tab)
  for i = 1, N do
    tab[i] = NOWORD
  end
end

function pushtotab(tab, word)
  for i = 1, N - 1 do
    tab[i] = tab[i + 1]
  end

  tab[N] = word
end

local prefixtab = {}

initializetab(prefixtab)

for w in allwords() do
  insert(prefix(prefixtab), w)
  pushtotab(prefixtab, w)
end

insert(prefix(prefixtab), NOWORD)

math.randomseed(os.time())

initializetab(prefixtab)

for i = 1, MAXGEN do
  local list = statetab[prefix(prefixtab)]
  local r = math.random(#list)
  local nextword = list[r]

  if nextword == NOWORD then return end

  io.write(nextword, " ")

  pushtotab(prefixtab, nextword)
end
