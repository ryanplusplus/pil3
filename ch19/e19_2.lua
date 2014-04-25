--[[
Write a function to compute the Hamming weight of a given integer.  (The Hamming weight of a number is the number of ones in its binary representation.)
]]

function printx(x)
  print(string.format("0x%X", x))
end

function hammingweight(n)
  weight = 0
  mask = 0x1
  while bit32.btest(mask) do
    if bit32.btest(mask, n) then
      weight = weight + 1
    end

    mask = bit32.lshift(mask, 1)
  end

  return weight
end

assert(hammingweight(0x1) == 1)
assert(hammingweight(0x2) == 1)
assert(hammingweight(0x4) == 1)
assert(hammingweight(0x8) == 1)
assert(hammingweight(0x100000) == 1)
assert(hammingweight(0x100110) == 3)
assert(hammingweight(0x70) == 3)

print("Everything worked!")
