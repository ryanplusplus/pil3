--[[
Write a transliterate function.  This function receives a string and replaces each character in that string by another character, according to a table given as a second argument.  If the table maps 'a' to 'b', the function should replace any occurrence of 'a' by 'b'.  If the table maps 'a' to false, the function should remove occurrences of 'a' from the resulting string.
]]

function transliterate(s, t)
  return (string.gsub(s, "(.)", function(c) return t[c] or '' end))
end

print(transliterate("hi._", {h = 'l', i = 'o', ['.'] = '!'})) --> "lo!"
