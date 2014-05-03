--[[
Write a function that returns the date/time exactly one month after a given date/time.  (Assume the usual coding of date/time as a number.)
]]

function onemonthlater(time)
  local date = os.date("*t", time)
  if date.month == 12 then
    date.month = 1
    date.year = date.year + 1
  else
    date.month = date.month + 1
  end
  return os.time(date)
end

local date = {year = 1970, month = 1, day = 1}
local expected = 31 * 24 * 60 * 60
assert((onemonthlater(os.time(date)) - os.time(date)) == expected)

local date = {year = 1970, month = 4, day = 1}
local expected = 30 * 24 * 60 * 60
assert((onemonthlater(os.time(date)) - os.time(date)) == expected)

print("Seems to work!")
