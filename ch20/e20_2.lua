--[[
A problem with table.sort is that the sort is not stable, that is, elements that the comparison function considers equal may not keep their original order in the array after the sort.  How can you do a stable sort in Lua?
]]

-- Bubble sort is crappy, but at least it's stable
function stablesort(a, comparator)
  comparator = comparator or function(a, b) return a < b end

  while true do
    local swapped = false
    for i = 2, #a do
      if comparator(a[i], a[i - 1]) then
        a[i], a[i - 1] = a[i - 1], a[i]
        swapped = true
      end
    end
    if not swapped then break end
  end
end

function rprint(l)
  function aux(l)
    if type(l) == "table" then
      io.write("{")
      for i, v in ipairs(l) do
        aux(v)
        if i ~= #l then io.write(", ") end
      end
      io.write("}")
    else
      io.write(tostring(l))
    end
  end
  aux(l)
  io.write("\n")
end

l = {{1, "first"}, {1, "second"}, {1, "third"}, {0, "should go to front"}}
stablesort(l, function(a, b) return a[1] < b[1] end)
rprint(l) --> {{0, should go to front}, {1, first}, {1, second}, {1, third}}
