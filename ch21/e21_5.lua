--[[
Rewrite the transliterate function for UTF-8 characters.
]]

function utf8transliterate(s, f)
  return (string.gsub(s, "(.[\128-\191]*)", f))
end

print(utf8transliterate("Sîne", function(c) return ({S = 'Æ', ["î"] = 'Ø'})[c] or '' end)) --> "ÆØ"
