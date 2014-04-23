--[[
Implement a class StackQueue as a subclass of Stack.  Besides the inherited methods, add to this class a method insertbottom, which inserts an element at the bottom of the stack.  (This method allows us to use objects of this class as queues.)
]]

StackQueue = require "stackqueue"

sq = StackQueue:new()

assert(sq:isempty())
assert(sq:top() == nil)

sq:push(3)
sq:push(4)
sq:insertbottom(2)
sq:insertbottom(1)

assert(sq:top() == 4)
assert(sq:pop() == 4)
assert(sq:pop() == 3)
assert(sq:pop() == 2)
assert(sq:pop() == 1)
assert(sq:isempty() == true)

print("Everything works!")
