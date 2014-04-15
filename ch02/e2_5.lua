--[[
Suppose you need to format a long sequence of arbitrary bytes as a string literal in Lua.  How would you do it?  Consider issues like readability, maximum line length, and performance.
]]

--[[
Although a string with arbitrary characters can be embedded in Lua, a text editor may mangle it.  If the string is encoded using hex escape sequences it will not be susceptible to mangling.  To address line length limitations the '\z' line continuation escape can be used.
]]
