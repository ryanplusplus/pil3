--[[
Reimplement the transliterate function (Exercise 21.3) in C.
]]

transliterate = (require 'transliterate').transliterate

print(transliterate("ohi._", function(c) return ({h = 'l', i = 'o', ['.'] = '!'})[c] or '' end)) --> "lo!"
