--[[
Modify the eight-queen program so that it stops after printing the first solution.
]]

local N = 8

local function isplaceok(a, n, c)
  for i = 1, n - 1 do
    local samecolumn = (a[i] == c)
    local samediagonal = (a[i] - 1 == c - n)  or (a[i] + 1 == c + n)
    if samecolumn or samediagonal then
      return false
    end
  end

  return true
end

local function printboard(a)
  for i = 1, N do
    for j = 1, N do
      io.write(a[i] == j and "X" or "-", " ")
    end

    io.write("\n")
  end

  io.write("\n")
end

local function addqueen(a, n)
  if n > N then
    printboard(a)
    error()
  else
    for c = 1, N do
      if isplaceok(a, n, c) then
        a[n] = c
        addqueen(a, n + 1)
      end
    end
  end
end

pcall(addqueen, {}, 1)
