Stack = require "stack"

StackQueue = Stack:new()

function StackQueue:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function StackQueue:insertbottom(o)
  temp = Stack:new()

  while not self:isempty() do
    temp:push(self:pop())
  end

  self:push(o)

  while not temp:isempty() do
    self:push(temp:pop())
  end
end

return StackQueue
