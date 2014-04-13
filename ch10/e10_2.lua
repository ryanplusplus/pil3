local N = 8
local isplaceokcount = 0
local addqueensolutions = {}
local permutationsolutions = {}

local function isplaceok(a, n, c)
  isplaceokcount = isplaceokcount + 1

  for i = 1, n - 1 do
    local samecolumn = (a[i] == c)
    local samediagonal = (a[i] - 1 == c - n)  or (a[i] + 1 == c + n)
    if samecolumn or samediagonal then
      return false
    end
  end

  return true
end

local function addqueen(a, n)
  if n > N then
    addqueensolutions[table.concat(a)] = true
  else
    for c = 1, N do
      if isplaceok(a, n, c) then
        a[n] = c
        addqueen(a, n + 1)
      end
    end
  end
end

function permgen(a, n)
    n = n or #a
    if n <= 1 then
        coroutine.yield(a)
    else
        for i = 1, n do
            a[n], a[i] = a[i], a[n]
            permgen(a, n - 1)
            a[n], a[i] = a[i], a[n]
        end
    end
end

function permutations(a)
    return coroutine.wrap(function() permgen(a) end)
end

addqueen({}, 1)

print("isplaceok called " .. tostring(isplaceokcount) .. " times using addqueens")

isplaceokcount = 0
local permutationcount = 0

for p in permutations{1, 2, 3, 4, 5, 6, 7, 8} do
  permutationcount = permutationcount + 1
  local valid = true

  for i, q in pairs(p) do
    if not isplaceok(p, i, q) then
      valid = false
      break
    end
  end

  if valid then
    permutationsolutions[table.concat(p)] = true
  end
end

print("Total permutations: " .. tostring(permutationcount))
print("isplaceok called " .. tostring(isplaceokcount) .. " times using permutations")

-- Double-check to make sure the solution sets are the same
for k, _ in pairs(addqueensolutions) do
  assert(permutationsolutions[k])
end

for k, _ in pairs(permutationsolutions) do
  assert(addqueensolutions[k])
end

--[[
The addqueens solution calls isplaceok 32536 compared to 40320 permutations.  The permutaiton
solution calls isplaceok 149112 times.

Even if each permutation took the same amount of time as isplaceok, performance would still
be worse, but because isplaceok is needed by the permutation solution (and called potentially
several times by each solution), the performance is actually far worse.  This is because the
permutation solution explores potential solutions that are known to be invalid because they
were partially explored and rejected as the head of a previous permutation.
]]

