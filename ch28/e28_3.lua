--[[
Reimplement the transliterate function (Exercise 21.3) in C.
]]

transliterate = (require 'transliterate').transliterate

print(transliterate("ohi._", {h = 'l', i = 'o', ['.'] = '!'})) --> "lo!"
