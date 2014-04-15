--[[
Implement a transfer function in Lua.  If you think about resume-yield as similar to call-return, a transfer would be like a goto: it suspends the running coroutine and resumes any other coroutine, given as an argument.  (Hint: use a kind of dispatch to control your coroutines.  Then, a transfer would yield to the dispatch signaling the next coroutine to run, and the dispatch would resume that next coroutine.)
]]

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
