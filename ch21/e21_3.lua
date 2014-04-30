--[[
Write a transliterate function.  This function receives a string and replaces each character in that string by another character, according to a table given as a second argument.  If the table maps 'a' to 'b', the function should replace any occurrence of 'a' by 'b'.  If the table maps 'a' to false, the function should remove occurrences of 'a' from the resulting string.
]]

function transliterate(s, f)
  return (string.gsub(s, "(.)", f))
end

print(transliterate("hi.", function(c) return ({h = 'l', i = 'o', ['.'] = '!'})[c] end)) --> "lo!"
