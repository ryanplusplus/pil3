--[[
Write an iterator fromto tsuch that the next two loops become equivalent:

for i in fromto(1, 5) do
  <body?
end

for i = n, m
  <body>
end

Can you implement it as a stateless iterator?
]]

function fromto_closure(n, m)
  local i = n

  return function()
    local _i = i
    i = i + 1
    if _i <= m then
      return _i
    else
      return nil
    end
  end
end

function iter_fromto(invariant, control)
  local to = invariant
  local current = control

  if current < to then
    return current + 1
  else
    return nil
  end
end

function fromto_stateless(n, m)
  return iter_fromto, m, n - 1
end

for i = 1, 5 do
  print(i)
end
--[[
1
2
3
4
5
]]

for i in fromto_closure(1, 5) do
  print(i)
end
--[[
1
2
3
4
5
]]

for i in fromto_stateless(1, 5) do
  print(i)
end
--[[
1
2
3
4
5
]]
