--[[
Which of the following are valid numerals?  What are their values?

.0e12
.e12
0.0e
0x12
0xABFG
0xA
FFFF
0xFFFFFFFF
0x
0x1P10
0.1e1
0x01.1
]]

local numerals = {
  ".0e12",
  ".e12",
  "0.0e",
  "0x12",
  "0xABFG",
  "0xA",
  "FFFF",
  "0xFFFFFFFF",
  "0x",
  "0x1P10",
  "0.1e1",
  "0x0.1p1"
}

for _, value in pairs(numerals) do
  local asNumber = tonumber(value)

  if asNumber then
    print(value .. " => " .. tostring(asNumber))
  else
    print(value .. " is not a valid numeral")
  end
end

--[[
.0e12 => 0
.e12 is not a valid numeral
0.0e is not a valid numeral
0x12 => 18
0xABFG is not a valid numeral
0xA => 10
FFFF is not a valid numeral
0xFFFFFFFF => 4294967295
0x is not a valid numeral
0x1P10 => 1024
0.1e1 => 1
0x0.1p1 => 0.125
]]
