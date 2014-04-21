--[[
The getfield function that we defined in the beginning of this chapter is too forgiving, as it accepts "fields" like math?sin or string!!!gsub.  Rewrite it so that it accepts only single dots as nameseparators.  (You may need some knowledge from Chapter 21 to do this exercise.)
]]

function getfield(f)
  local v = _G
  for w in string.gmatch(f, "[^.]+") do -- Split on '.'
    v = v[w]
  end
  return v
end

t = {x = {y = 5}}

print(getfield("t.x.y")) --> 5
print(getfield("t?x?y")) --> nil
