function integral(f, delta)
  delta = delta or 1e-4
  local function integrate(a, b)
    -- Assumes a 'forward' integral
    local function aux(a, b)
      local area = 0

      -- Storing this means we don't evaluate f more than necessary
      local previous = f(a)

      for x = a + delta, b, delta do
        local current = f(x)
        area = area + ((previous + current) / 2) * delta
        previous = current
      end

      return area
    end

    if a < b then
      return aux(a, b)
    else
      return -aux(b, a)
    end
  end

  return integrate
end

function line(m, b)
  return function(x) return m*x + b end
end

function x_squared()
  return function(x) return x*x end
end

print(integral(line(0, 1))(3, 4)) --> 0.99999999999991
print(integral(line(0, 1))(4, 3)) --> -0.99999999999991

print(integral(line(1, 0))(0, 2)) --> 1.9999999999998
print(integral(line(1, 0))(0, 4)) --> 7.9996000050036

print(integral(x_squared())(-4, 4)) --> 42.66506672005
print(integral(x_squared(), 2)(-4, 4)) --> 48
