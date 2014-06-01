--[[
Implement in the lproc library a non-blocking send operation.
]]

lproc = require 'lproc'

lproc.start("(function() \
  print(lproc.receive('a')) \
  lproc.send('a', 'pong') \
  lproc.exit() \
end)()")
lproc.trysend('b')
while not lproc.trysend('a', 'ping') do io.write('.') end -- Indicate each failed send with a '.'
print(lproc.receive('a'))
--[[
.........................ping
pong
]]
