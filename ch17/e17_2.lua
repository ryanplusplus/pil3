--[[
Consider the first example of Section 17.6 which creates a table with a finalizer that only prints a message when activated.  What happens if the program ends without a collection cycle?  What happens if the program calls os.exit?  What happens if the program ends with some error?
]]

--[[
lua e17_2_no_collection.lua --> finalizer invoked

lua e17_2_os_exit.lua -->

lua e17_2_error.lua --> finalizer invoked
]]
