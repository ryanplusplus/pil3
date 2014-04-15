--[[
Write a function that receives an arbitrary number of strings and returns all of them concatenated together.
]]

function string_catter(...)
  local s = ""

  for _, v in ipairs{...} do
    s = s .. v
  end

  return s
end

print(string_catter("a", "b", "c", "d")) --> 'abcd'
