--[[
Another way to provide privacy for objects is to implement them using proxies (Section 13.4).  Each object is represented by an empty proxy table.  An internal table maps proxies to tables that carry the object state.  This internal table is not accessible from the outside, but methods use it to translate their self parameters to the real tables where they operate.  Implement the Account example using this approach and discuss its pros and cons.

(There is a small problem with this approach.  Try to figure it out or see Section 17.3, which also presents a solution.)
]]

Account = {balance = 0}

function Account:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Account:deposit(v)
  self.balance = self.balance + v
end

function Account:withdraw(v)
  if v > self.balance then error "insufficient funds" end
  self.balance = self.balance - v
end

function Account:getbalance()
  return self.balance
end

a = Account:new()

a:deposit(100)
assert(a:getbalance() == 100)

a:withdraw(60)
assert(a:getbalance() == 40)

print("Everything works!")

-- weak tables
