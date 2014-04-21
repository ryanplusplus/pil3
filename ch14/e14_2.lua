--[[
Explain in detail what happens in the following program and what its output is.

local foo
do
  local _ENV = _ENV
  function foo() print(X) end
end
X = 13
_ENV = nil
foo()
X = 0
]]

local foo
do
  local _ENV = _ENV -- _G => _ENV
  function foo() print(X) end -- Create a closure with _ENV == _G
end
X = 13 -- 13 => _G.X
_ENV = nil
foo() -- Invoke foo with _ENV == _G; this will print 13 because _G.X is 13
X = 0 -- Attempt to create a field in nil and bomb out
--[[
13
lua: e14_2.lua:23: attempt to index upvalue '_ENV' (a nil value)
stack traceback:
  e14_2.lua:23: in main chunk
  [C]: in ?
]]
