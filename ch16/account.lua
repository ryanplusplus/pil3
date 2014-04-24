Account = {}
local proxies = {__mode = "k"}

function Account:new(o)
  local o = o or {}
  proxies[o] = {balance = 0}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Account:deposit(v)
  proxies[self].balance = proxies[self].balance + v
end

function Account:withdraw(v)
  if v > proxies[self].balance then error "insufficient funds" end
  proxies[self].balance = proxies[self].balance - v
end

function Account:balance()
  return proxies[self].balance
end

return Account
