--[[
Suppose that you want to create a table that associates each escape sequence for strings (see Section 2.4) with its meaning.  How could you write a constructor for that table?
]]

local escape_sequences = {
   ['\a'] = "bell",
   ['\b'] = "backspace",
   ['\f'] = "form feed",
   ['\n'] = "newline",
   ['\r'] = "carriage return",
   ['\t'] = "horizontal tab",
   ['\v'] = "vertical tab",
   ['\\'] = "backslash",
   ['\"'] = "double quote",
   ['\''] = "single quote"
}

for sequence, meaning in pairs(escape_sequences) do
  print(meaning .. ": " .. sequence)
end
