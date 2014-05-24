--[[
Implement a library with a modification of transliterate so that the transliteration table is not given as an argument, but instead is kept by the library.  Your library should offer the following functions:

lib.settrans(table)  -- set the transliteration table
lib.gettrans()       -- get the transliteration table
lib.transliterate(s) -- transliterate 's' according to the current table

Use the registry to keep the transliteration table.
]]

lib = require 'e28_4lib'

lib.settrans({h = 'l', i = 'o', ['.'] = '!'})
print(lib.gettrans().h) --> "l"
print(lib.transliterate("ohi._")) --> "lo!"
