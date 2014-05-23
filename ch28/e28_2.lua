--[[
Modify function l_split (from Listing 28.2) so that it can work with strings containing zeros.  (Among other changes, it should use memchr instead of strchr.)
]]

l_split = (require 'l_split').l_split

for _, v in pairs(l_split('a\0b:c:d\0e', ':')) do
  print(v)
end
--[[
ab
c
de
]]
