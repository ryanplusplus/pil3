Stack = {}

function Stack:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Stack:push(o)
  self[#self + 1] = o
end

function Stack:pop()
  o = self:top()
  self[#self] = nil
  return o
end

function Stack:top()
  return self[#self]
end

function Stack:isempty()
  return nil == self:top()
end

return Stack
