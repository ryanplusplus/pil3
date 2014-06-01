--[[
Modify the lproc library so that it can send and receive other primitive types such as booleans and numbers.  (Hint: you only have to modify the movevalues function.)
]]

lproc = require 'lproc'

lproc.start("(function() \
  print(lproc.receive('a')) \
  lproc.send('a', 'pong') \
  lproc.exit() \
end)()")
lproc.send('a', 'ping')
print(lproc.receive('a'))
--[[
ping
pong
]]

lproc.start("(function() \
  print(lproc.receive('b')) \
  lproc.send('b', true) \
  lproc.exit() \
end)()")
lproc.send('b', 42)
print(lproc.receive('b'))
--[[
42
true
]]
