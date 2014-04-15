--[[
What is the value of the expression type(nil) == nil?  (You can use Lua to check your answer.)  Can you explain this result?
]]

print("type(nil) == nil => " .. tostring(type(nil) == nil))
-- type(nil) == nil => false

print("type(type(nil)) => " .. type(type(nil)))
-- type(type(nil)) => string

print("type(nil) => " .. type(nil))
-- type(nil) => nil

-- Evaluates to ["nil" == nil] => types don't match
