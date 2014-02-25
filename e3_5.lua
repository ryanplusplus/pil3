function is_boolean(x)
  return (x == true) or (x == false)
end

print(is_boolean(true))   --> true
print(is_boolean(false))  --> true
print(is_boolean(3))      --> false
print(is_boolean(nil))    --> false
print(is_boolean(0))      --> false
print(is_boolean({}))     --> false
print(is_boolean(""))     --> false
