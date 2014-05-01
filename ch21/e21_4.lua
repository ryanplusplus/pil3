--[[
Write a function to reverse a UTF-8 string.
]]

function utf8reverse(s)
  res = {}
  for c in string.gmatch(s, ".[\128-\191]*") do
    table.insert(res, 1, c)
  end
  return table.concat(res)
end

print(utf8reverse("Sîne klâwen")) --> "newâlk enîS"
