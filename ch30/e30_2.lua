--[[
In the lxp example, the handler for start elements receives a table with the element attributes.  In that table, the original order in which the attributes appear inside the element is lost.  How can you pass this information to the callback?
]]

--[[
If you wish to retain the order, you can create the table with indices instead of attribute names as keys.  Then, as the data, you can pass a table of the form {name = "name", value = "value"}.
]]
