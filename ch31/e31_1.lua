--[[
As we saw, if a function calls lua_yield (the version with no continuation), control returns to the function that called it when the thread resumes again.  What values does the calling function receive as results from that call?
]]

yieldtest = require 'yieldtest'

co = coroutine.create(yieldtest.yield)
print(coroutine.resume(co)) --> true  the answer to life, the universe and everything 42

--[[
Calling lua_yield returns the same arguments that would have been returned from lua_yieldk.  In this case, two arguments were returned as specified by nresults (plus 'true' because the coroutine ran without errors).
]]
