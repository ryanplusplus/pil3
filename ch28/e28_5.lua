--[[
Repeat the previous exercise using an upvalue to keep the transliteration table.
]]

lib = require 'e28_5lib'

lib.settrans({h = 'l', i = 'o', ['.'] = '!'})
print(lib.gettrans().h) --> "l"
print(lib.transliterate("ohi._")) --> "lo!"
