--[[
For this exercise, you need at least one Lua script that uses lots of memory.  If you do not have one, write it.  (It can be as simple as a loop creating tables.)

Run your script with different GC parameters.  How they affect the performance of the script?

What happens if you set the GC pause to zero?  What happens if you set the GC pause to 1000?

What happens if you set the step multiplier to zero?  What happens if you set the step multiplier to 1000000?

Adapt your script so that it keeps full control over the garbage collector.  It should keep the collector stopped and call it from time to time to do some work.  Can you improve the performance of your script with this approach?
]]

local default = {
  pause = collectgarbage('setpause', 0),
  step = collectgarbage('setstepmul', 0)
}

function benchmark(name, config)
  config = config or {}

  -- Start fresh
  collectgarbage('collect')

  collectgarbage('setpause', config.pause or default.pause)
  collectgarbage('setstepmul', config.step or default.step)
  if config.disabled then
    collectgarbage('stop')
  else
    collectgarbage('restart')
  end

  local start = os.clock()
  for _ = 1, 100000 do
    local t = {}
    for i = 1, 100 do
      t[i] = {i}
    end
  end
  print(name .. ' = {\n\ttime = ' .. os.clock() - start .. ' sec,\n\tmem = ' .. tostring(collectgarbage('count') * 1024) .. ' bytes\n}')
end

benchmark('baseline')
benchmark('pause is 0', {pause = 0})
benchmark('pause is 1000', {pause = 1000})
benchmark('step is 0', {step = 0})
benchmark('step is 1000000', {step = 1000000})
benchmark('gc disabled', {disabled = true})
--[[
baseline = {
  time = 3.634422 sec,
  mem = 96916 bytes
}
pause is 0 = {
  time = 16.538695 sec,
  mem = 35852 bytes
}
pause is 1000 = {
  time = 3.498946 sec,
  mem = 268860 bytes
}
step is 0 = {
  time = 3.551357 sec,
  mem = 222492 bytes
}
step is 1000000 = {
  time = 3.641343 sec,
  mem = 56508 bytes
}
gc disabled = {
  time = 2.191582 sec,
  mem = 1011225612 bytes
}
]]

--[[
For this workload, the garbage collector is not actually needed because the system memory is sufficient to keep all objects in memory simultaneously.  The garbage collector can be configured to run either very infrequently or be disabled entirely in order to trade memory for throughput.
]]
