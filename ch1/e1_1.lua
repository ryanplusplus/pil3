function fact(n)
  if n < 0 then
    error()
  elseif n == 0 then
    return 1
  else
    return n * fact(n - 1)
  end
end

print(fact(5))
print(fact(3))
print(fact(-1))
