--[[
Write a function to determine whether the binary representation of a number is a palindrome.
]]

function ispalindrome(n)
  local function binaryreplen(n)
    local len = 0
    for i = 1, 32 do
      if bit32.extract(n, i - 1, 1) > 0 then
        len = i
      end
    end
    return len
  end

  local len = binaryreplen(n)
  for i = 1, math.floor(len / 2) do
    local near = bit32.extract(n, i - 1, 1)
    local far = bit32.extract(n, len - i)
    if near ~= far then return false end
  end

  return true
end

assert(ispalindrome(0xF) == true)
assert(ispalindrome(0x1) == true)
assert(ispalindrome(0xFF) == true)
assert(ispalindrome(0x81) == true)
assert(ispalindrome(0x2) == false)
assert(ispalindrome(0x6) == false)
assert(ispalindrome(0xFFFF) == true)
assert(ispalindrome(0xFFFE) == false)

print("Everything works!")
