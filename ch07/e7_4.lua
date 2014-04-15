--[[
Write an iterator that returns all non-empty substrings of a given string.  (You will need the string.sub function.)
]]

function substrings(s)
  local pos = 1
  local ssend = 1

  return function()
    if ssend > #s then
      pos = pos + 1
      ssend = pos
    end

    if pos > #s then
      return nil
    end

    local current = string.sub(s, pos, ssend)
    ssend = ssend + 1

    return current
  end
end

for ss in substrings("abc") do
  print(ss)
end

--[[
a
ab
abc
b
bc
c
]]
