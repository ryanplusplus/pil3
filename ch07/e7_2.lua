function fromto_closure(from, to, step)
  local i = from
  step = step or 1

  return function()
    local _i = i
    i = i + step
    if _i <= to then
      return _i
    else
      return nil
    end
  end
end

function iter_fromto(invariant, control)
  local to = invariant.to
  local step = invariant.step
  local current = control

  if current < to then
    return current + step
  else
    return nil
  end
end

function fromto_stateless(from, to, step)
  step = step or 1
  return iter_fromto, {to = to, step = step}, (from - step)
end

for i = 1, 9, 2 do
  print(i)
end
--[[
1
3
5
7
9
]]

for i in fromto_closure(1, 9, 2) do
  print(i)
end
--[[
1
3
5
7
9
]]

for i in fromto_stateless(1, 9, 2) do
  print(i)
end
--[[
1
3
5
7
9
]]
