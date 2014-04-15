--[[
We can represent a polynomial an * x^n + an-1 * x^n-1 + ... + a1 * x^1 + ao in Lua as a list of its coefficients, such as {ao, a1, ..., an}.

Write a function that receives a polynomial (represented as a table) and a value for x and returns the polynomial value.
]]

function calc_poly(coeffs, x)
  local sum = 0

  for i, coeff in pairs(coeffs) do
    sum = sum + coeff * x^(i - 1)
  end

  return sum
end

print(calc_poly({1, 2, 3}, 4)) --> 57 = 1 + 2*x + 3*x^2 => 1 + 8 + 3 * 16 => 57
