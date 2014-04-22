--[[
What happens in the search for a library if the path has some fixed component (that is, a component without a question mark)?  Can this behavior be useful?
]]

package.path = package.path .. ";set.lua"

Set = require "somethingThatDoesntExist"

print(Set.new{1, 2, 3, 4} + Set.new{3, 4, 5, 6}) --> {1, 2, 3, 4, 5, 6}
print(Set.new{1, 2, 3, 4} - Set.new{3, 4, 5, 6}) --> {1, 2}

--[[
Apparently Lua is perfectly happy to use a path without a question mark.  In this case I added the fixed component last so that Lua fell back on it as a default.  I suppose this could be useful as a sort of default package that gets loaded when the requested package can't be found.  Why one would choose to do this instead of simply handling a failed lookup with pcall eludes me.
]]
