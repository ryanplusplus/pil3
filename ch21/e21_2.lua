--[[
The patterns '%D' and '[^%d]' are equivalent. What about the patterns '[^%d%u]' and '[%D%U]'?
]]

--[[
[^%d%u] => ~(digit or upper-case letter) => ~(digit) and ~(upper-case letter)
[%D%U] => ~digit or ~upper-case letter
]]

print(string.match("1", "[^%d%u]")) --> nil
print(string.match("1", "[%D%U]")) --> "1"

print(string.match("A", "[^%d%u]")) --> nil
print(string.match("A", "[%D%U]")) --> "A"
