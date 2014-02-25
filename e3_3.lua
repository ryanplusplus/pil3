function calc_poly(coeffs, x)
  local sum = 0

  for i, coeff in pairs(coeffs) do
    sum = sum + coeff * x^(i - 1)
  end

  return sum
end

print(calc_poly({1, 2, 3}, 4)) --> 57 = 1 + 2*x + 3*x^2 => 1 + 8 + 3 * 16 => 57
