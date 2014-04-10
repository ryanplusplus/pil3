co1 = coroutine.create(function()
  print('1')
  transfer(co2)
  print('3')
  transfer(co3)
end)

co2 = coroutine.create(function()
  print('2')
  transfer(co1)
  print('5')
end)

co3 = coroutine.create(function()
  print('4')
  transfer(co2)
end)

function transfer(co)
  coroutine.yield(co)
end

function dispatch(co)
  if co then
    dispatch(({coroutine.resume(co)})[2])
  end
end

dispatch(co1)

--[[
1
2
3
4
5
]]
