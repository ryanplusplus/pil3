--[[
Write a function to test whether a given table is a valid sequence.
]]

--[[
Definition of a sequence from the text:
"...a sequence is a table where the numeric keys comprise a set 1, . . . , n for some n."
]]

function isvalidsequence(t)
  for i in pairs(t) do
    if type(i) == "number" and (i > #t or i < 1) then
      return false
    end
  end
  return true
end

assert(isvalidsequence{1, 2, 3, 4, 5} == true)
assert(isvalidsequence{1, 2, 3, 4, 5, k = true} == true)
assert(isvalidsequence{1, 2, 3, 4, 5, k = true, [7] = true} == false)
assert(isvalidsequence{1, 2, 3, 4, 5, [7] = true} == false)
assert(isvalidsequence{1, 2, 3, 4, 5, [0] = true} == false)
assert(isvalidsequence{1, 2, 3, 4, 5, [-1] = true} == false)

print("Everything works!")
