--[[
Consider the following expression:
(x and y and (not z)) or ((not y) and x)

Are the parentheses necessary?  Would you recommend their use in that expression?
]]

--[[
Priority:
not > and > or

Given:
(x and y and (not z)) or ((not y) and x)

Because not > and we can write this as:
(x and y and not z) or (not y and x)

Because and, not > or we can write this as:
x and y and not z or not y and x

So the parenthesized and non-parenthesized versions are equivalent.  However, the non-parenthesized version is significantly less readable.
]]

-- Sanity check

function parenthesized(x, y, z)
  return (x and y and (not z)) or ((not y) and x)
end

function non_parenthesized(x, y, z)
  return x and y and not z or not y and x
end

for _, x in pairs({true, false}) do
  for _, y in pairs({true, false}) do
    for _, z in pairs({true, false}) do
      if(parenthesized(x, y, z) ~= non_parenthesized(x, y, z)) then
        error("Not equivalent")
      end
    end
  end
end

print("Equivalent")
