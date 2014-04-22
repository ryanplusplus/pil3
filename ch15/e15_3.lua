--[[
Write a searcher that searches for Lua files and C libraries at the same time.  For instance, the path used for this searcher could be something like this:

./?.lua;./?.so;/usr/lib/lua5.2/?.so;/usr/share/lua5.2/?.lua

(Hint: use package.searchpath to find a proper file and then try to load it, first with loadfile and next with package.loadlib)
]]

-- Take over all searching duties and crush all those who oppose us
package.searchers = {
  function(name)
    local file = package.searchpath(name, "./?.lua;./?.so;/usr/lib/lua5.2/?.so;/usr/share/lua5.2/?.lua")
    return package.loadlib(file, "*") or loadfile(file)  -- Do loadlib first to demonstrate graceful failure
  end
}

-- Now show that this actually works
Set = require "Set"

print(Set.new{1, 2, 3, 4} + Set.new{3, 4, 5, 6}) --> {1, 2, 3, 4, 5, 6}
print(Set.new{1, 2, 3, 4} - Set.new{3, 4, 5, 6}) --> {1, 2}
