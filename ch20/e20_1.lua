--[[
Rewrite function rconcat so that it can get a separator, just like table.concat does:

print(rconcat({{{"a", "b"}, {"c"}}, "d", {}, {"e"}}, ";"))
--> a;b;c;d;e
]]

function rconcat(l, separator)
  function aux(l)
    if type(l) ~= "table" then return {l} end
    local res = {}
    for i = 1, #l do
      for _, v in ipairs(aux(l[i])) do
        res[#res + 1] = v
      end
    end
    return res
  end

  return table.concat(aux(l), separator)
end

assert("a;b;c;d;e" == rconcat({{{"a", "b"}, {"c"}}, "d", {}, {"e"}}, ";"))
assert("abcde" == rconcat({{{"a", "b"}, {"c"}}, "d", {}, {"e"}}))

print("Everything works!")
