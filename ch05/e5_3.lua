--[[
Write a function that receives an arbitrary number of values and returns all of them, except the first one.
]]

function all_but_first(...)
  local args = table.pack(...)

  function aux(i)
    if i <= args.n then
      return args[i], aux(i + 1)
    end
  end

  return aux(2)
end

function all_but_first_better(first, ...)
  return ...
end

print(all_but_first(1,2,3,4)) --> 2 3 4
print(all_but_first("hello", "world", nil, 42)) --> world nil 42

print(all_but_first_better(1,2,3,4)) --> 2 3 4
print(all_but_first_better("hello", "world", nil, 42)) --> world nil 42
