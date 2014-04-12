print("type(nil) == nil => " .. tostring(type(nil) == nil))
-- type(nil) == nil => false

print("type(type(nil)) => " .. type(type(nil)))
-- type(type(nil)) => string

print("type(nil) => " .. type(nil))
-- type(nil) => nil

-- Evaluates to ["nil" == nil] => types don't match
