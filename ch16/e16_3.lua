--[[
Another way to provide privacy for objects is to implement them using proxies (Section 13.4).  Each object is represented by an empty proxy table.  An internal table maps proxies to tables that carry the object state.  This internal table is not accessible from the outside, but methods use it to translate their self parameters to the real tables where they operate.  Implement the Account example using this approach and discuss its pros and cons.

(There is a small problem with this approach.  Try to figure it out or see Section 17.3, which also presents a solution.)
]]

Account = require "account"

a = Account:new()

a:deposit(100)
assert(a:balance() == 100)

a:withdraw(60)
assert(a:balance() == 40)

print("Everything works!")

--[[
The problem with this approach is that an object can never be freed because the proxy table will always hold a reference to the object.  To resolve this the proxy table was set to have weak keys.
]]
