--[[
Explain in detail what happens in the following program and what its output is.

local print = print
function foo(_ENV, a)
  print(a + b)
end

foo({b = 14}, 12)
foo({b = 10}, 1)
]]

local print = print
function foo(_ENV, a)
  print(a + b) -- a will be the parameter 'a', b will be retrieved from _ENV
end

foo({b = 14}, 12) -- Print the sum of 14 and 12 (ie: 26)
foo({b = 10}, 1) -- Print the sum of 10 and 1 (ie: 11)
--[[
26
11
]]
