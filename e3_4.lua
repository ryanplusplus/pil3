--[[
We can factor out x to get rid of exponentiation.  Consider n = 3:
c3*x^3 + c2*x^2 + c1*x + c0
(c3*x^2 + c2*x + c1)*x + c0
((c3*x + c2)*x + c1)*x + c0
(((c3)*x + c2)*x + c1)*x + c0
]]

function calc_poly(coeffs, x)
  local sum = coeffs[#coeffs]

  for i = #coeffs - 1, 1, -1 do
    sum = sum * x + coeffs[i]
  end

  return sum
end

function recursive_calc_poly(coeffs, x)
  function aux(n)
    return coeffs[n] + (n < #coeffs and aux(n + 1) * x or 0)
  end
  return aux(1)
end

print(calc_poly({1, 2, 3}, 4)) --> 57 = 1 + 2*x + 3*x^2 => 1 + 8 + 3 * 16 => 57
print(recursive_calc_poly({1, 2, 3}, 4)) --> 57 = 1 + 2*x + 3*x^2 => 1 + 8 + 3 * 16 => 57
