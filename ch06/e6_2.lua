--[[
Exercise 3.3 asked you to write a function that receives a polynomial (represented as a table) and a value for its varaible, and returns the polynomial value.  Write the curried version of that function.  Your function should receive a polynomial and returns a function that, when called with a value for x, returns the value of the polynomial for that x.  See the example:

f = newpoly({3, -, 1})
print(f(0)) --> 1
print(f(5)) --> 76
print(f(10)) --> 301
]]

function poly(coeffs)
  return function(x)
    local sum = 0

    for i, coeff in pairs(coeffs) do
      sum = sum + coeff * x^(i - 1)
    end

    return sum
  end
end

print(poly{1, 2, 3}(4)) --> 57 = 1 + 2*x + 3*x^2 => 1 + 8 + 3 * 16 => 57
