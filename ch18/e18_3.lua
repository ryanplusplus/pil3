--[[
Implement a better random function in Lua.  Search the Web for a good algorithm.  (You may need the bitwise library; see Chapter 19.)
]]

--[[
I stole this example and the expected output from:
http://www.cs.princeton.edu/courses/archive/fall10/cos126/assignments/lfsr.html
]]

do
  local nbits = 11
  local tap = 9
  local state = 0

  local function step()
    local msb = bit32.extract(state, nbits - 1, 1)
    local tapbit = bit32.extract(state, tap - 1, 1)
    local newbit = bit32.bxor(msb, tapbit)
    state = bit32.extract(bit32.lshift(state, 1), 0, nbits)
    state = bit32.bor(state, newbit)
  end

  function seed(s)
    state = s
  end

  function rand(bits)
    gen = 0
    for i = 1, bits do
      step()
      gen = bit32.bor(bit32.extract(state, 0, 1), bit32.lshift(gen, 1))
    end
    return gen
  end
end

seed(0x342)
for i = 1, 10 do
  print(rand(1))
end
--[[
1
1
0
0
1
0
0
1
0
0
]]

seed(0x342)
for i = 1, 10 do
  print(rand(5))
end
--[[
25
4
30
27
18
26
28
24
23
29
]]
