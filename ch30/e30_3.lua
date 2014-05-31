--[[
In the lxp example, we used user values to associate the callback table with the userdatum that represents a parser.  This choice created a small problem, because what the C callbacks receive is the lxp_userdata structure, and that structure does not offer direct access to the table.  We solved this problem by storing the callback table at a fixed stack index during the parse of each fragment.

An alternative design would be to associate the callback table with the user-datum through references (Section 28.3): we create a reference to the callback table and store the reference (an integer) in the lxp_userdata structure.  Implement this alternative.  Do not forget to release the reference when closing the parser.
]]

lxp = require 'lxp'

local count = 0

callbacks = {
  StartElement = function(parser, tagname)
    io.write('+ ', string.rep(' ', count), tagname, '\n')
    count = count + 1
  end,

  EndElement = function(parser, tagname)
    count = count - 1
    io.write('- ', string.rep(' ', count), tagname, '\n')
  end,

  CharacterData = function(parser, chardata)
    io.write('* ', string.rep(' ', count), chardata, '\n')
  end
}

parser = lxp.new(callbacks)

parser:parse('<to><yes/><text>some text</text></to>')
parser:close()
--[[
+ to
+  yes
-  yes
+  text
*   some text
-  text
- to
]]
