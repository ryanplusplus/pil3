--[[
function getlabel()
  return function() goto L1 end
  :: L1::
  return 0
end

function f(n)
  if n == 0 then return getlabel()
  else
    local res = f(n - 1)
    print(n)
    return res
  end
end

x = f(10)
x()
]]

--[[
If it were possible to goto out of a function
then the above would be equivalent to this:
]]
function getlabel()
  return function() return 0 end
end

function f(n)
  if n == 0 then return getlabel()
  else
    local res = f(n - 1)
    print(n)
    return res
  end
end

x = f(10)
x()

--[[
1
2
3
4
5
6
7
8
9
10
]]
