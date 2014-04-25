--[[
Write a function to test whether a given integer is a power of two.
]]

function ispoweroftwo(n)
  mask = 0x1
  while bit32.btest(mask) do
    if bit32.band(n) == mask then
      return true
    end

    mask = bit32.lshift(mask, 1)
  end

  return false
end

print(ispoweroftwo(4)) --> true
print(ispoweroftwo(5)) --> false
print(ispoweroftwo(15)) --> false
print(ispoweroftwo(16)) --> true
print(ispoweroftwo(1024)) --> true
print(ispoweroftwo(2048)) --> true
