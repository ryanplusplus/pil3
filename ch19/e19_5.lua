--[[
Write a function that receives a string coded in UTF-8 and returns its first code point as a number.  The function should return nil if the string does not start with a valid UTF-8 sequence.
]]

function firstcodepoint(s)
  function seqlen(s)
    local start = string.byte(s, 1)

    if bit32.band(start, 0x80) == 0x00 then return 1 end
    if bit32.band(start, 0xE0) == 0xC0 then return 2 end
    if bit32.band(start, 0xF0) == 0xE0 then return 3 end
    if bit32.band(start, 0xF8) == 0xF0 then return 4 end
    if bit32.band(start, 0xFC) == 0xF8 then return 5 end
    if bit32.band(start, 0xFE) == 0xFC then return 6 end

    return 0
  end

  function valid(s)
    local len = seqlen(s)

    if len == 0 then return false end

    for i = 2, len do
      if bit32.band(string.byte(s, i), 0xC0) ~= 0x80 then
        return false
      end
    end

    return true
  end

  if not valid(s) then return false end

  local codepoint = bit32.extract(string.byte(s, 1), 0, 7 - seqlen(s))

  for i = 2, seqlen(s) do
    codepoint = bit32.lshift(codepoint, 6)
    codepoint = bit32.bor(codepoint, bit32.extract(string.byte(s, i), 0, 6))
  end

  return codepoint
end

assert("0x20AC" == string.format("0x%X", firstcodepoint("€")))
assert("0x24B62" == string.format("0x%X", firstcodepoint("𤭢")))

print("Everything works!")
