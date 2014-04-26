--[[
Define the shift operations and the bitwise not using the arithmetic operators in Lua.
]]

function lshift(n, count)
  for _ = 1, count do
    n = n * 2
  end
  return n
end

function rshift(n, count)
  for _ = 1, count do
    n = n / 2
  end
  return math.floor(n)
end

function bnot(n)
  res = 0
  for i = 1, 32 do
    res = lshift(res, 1)
    if rshift(n, 32 - i) % 2 == 0 then
      res = res + 1
    end
  end
  return res
end

assert(lshift(345, 1) == bit32.lshift(345, 1))
assert(lshift(345, 2) == bit32.lshift(345, 2))
assert(lshift(345, 3) == bit32.lshift(345, 3))
assert(lshift(1234, 1) == bit32.lshift(1234, 1))
assert(lshift(1234, 2) == bit32.lshift(1234, 2))
assert(lshift(1234, 3) == bit32.lshift(1234, 3))

assert(rshift(345, 1) == bit32.rshift(345, 1))
assert(rshift(345, 2) == bit32.rshift(345, 2))
assert(rshift(345, 3) == bit32.rshift(345, 3))
assert(rshift(1234, 1) == bit32.rshift(1234, 1))
assert(rshift(1234, 2) == bit32.rshift(1234, 2))
assert(rshift(1234, 3) == bit32.rshift(1234, 3))

assert(bnot(1234) == bit32.bnot(1234))
assert(bnot(5432) == bit32.bnot(5432))
assert(bnot(0xF0000000) == bit32.bnot(0xF0000000))
assert(bnot(0x0000000F) == bit32.bnot(0x0000000F))

print("Everything works!")
