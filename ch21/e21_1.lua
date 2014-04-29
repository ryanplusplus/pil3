--[[
Write a split function that receives a string and a delimiter pattern and returns a sequence with the chunks in the original string separated by the delimiter:

t = split("a whole new world", " ")
-- t = {"a", "whole", "new", "world"}
]]

function split(s, delimiter)
  res = {}
  for word in string.gmatch(s, "[^" .. delimiter .. "]+") do
    res[#res + 1] = word
  end
  return res
end

function printres(res)
  io.write("{")
  for i, v in ipairs(res) do
    io.write('"' .. v .. '"')
    if i < #res then io.write(", ") end
  end
  print("}")
end

printres(split("a whole new world", " ")) --> {"a", "whole", "new", "world"}
printres(split("a;whole;new;world", " ")) --> {"a;whole;new;world"}
printres(split("a;whole;new;world", ";")) --> {"a", "whole", "new", "world"}
printres(split("a9whole;new7world", "%d;")) --> {"a", "whole", "new", "world"}
