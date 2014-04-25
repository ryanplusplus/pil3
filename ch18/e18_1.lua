--[[
Write a function to test whether a given number is a power of two.
]]

function ispoweroftwo(n)
  log = math.log(n, 2)

  return log == math.floor(log)
end

print(ispoweroftwo(-4)) --> false
print(ispoweroftwo(4)) --> true
print(ispoweroftwo(5)) --> false
print(ispoweroftwo(15)) --> false
print(ispoweroftwo(16)) --> true
print(ispoweroftwo(1024)) --> true
print(ispoweroftwo(0.5)) --> true
