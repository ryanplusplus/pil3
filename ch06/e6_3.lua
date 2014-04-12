--[[
Example of a tail call optimization without recursion.

Mutually recursive implementations of is_odd/even that works only on positive integers.
]]

local is_even, is_odd

function is_odd(x)
  if x == 0 then
    return false
  else
    return is_even(x - 1)
  end
end

function is_even(x)
  if x == 0 then
    return true
  else
    return is_odd(x - 1)
  end
end

print(is_even(123)) --> false
print(is_odd(123)) --> true
print(is_even(432)) --> true
print(is_odd(432)) --> false

-- And to convince ourselves that this is actually TCO'ed...
print(is_even(123456789)) --> false
