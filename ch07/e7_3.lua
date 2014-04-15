--[[
Write an iterator uniquewords that returns all words from a given file without repetitions.  (Hint: start with the allwords code in Listing 7.1; use a table to keep all words already reported.)
]]

function uniquewords()
  local line = io.read()
  local pos = 1
  local found_words = {}

  return function()
    while line do
      local s, e = string.find(line, "%w+", pos)

      if s then
        pos = e + 1
        local word = string.sub(line, s, e)

        if not found_words[word] then
          found_words[word] = true
          return word
        end
      else
        line = io.read()
        pos = 1
      end
    end

    return nil
  end
end

for word in uniquewords() do
  print(word)
end

-- echo "aaa bbb ccc aaa bbb ccc ddd" | lua e7_3.lua
--[[
aaa
bbb
ccc
ddd
]]
