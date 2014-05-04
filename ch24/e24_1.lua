--[[
Why the recursion in function getvarvalue (Listing 24.1) is guaranteed to stop?
]]

--[[
There are a couple of pieces to this:
1) Local variables -- this section will terminate because there can only be a finite number of local variables.
2) Non-local variables -- this section will terminate because there can only be a finite number of upvalues.
3) _ENV lookup -- this will terminate because every function has a pre-defined _ENV upvalue so the recursive call will end, at the very latest, in the non-local variable (upvalue) section.
]]
