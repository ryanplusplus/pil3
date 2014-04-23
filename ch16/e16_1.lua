--[[
Implement a class Stack, with methods push, pop, top, and isempty.
]]

Stack = require "stack"

s = Stack:new()

assert(s:top() == nil)
assert(s:isempty() == true)

s:push(4)
assert(s:top() == 4)
assert(s:isempty() == false)

s:push(5)
assert(s:top() == 5)
assert(s:isempty() == false)

assert(s:pop() == 5)
assert(s:top() == 4)
assert(s:isempty() == false)

assert(s:pop() == 4)
assert(s:top() == nil)
assert(s:isempty() == true)

print("Everything works!")
