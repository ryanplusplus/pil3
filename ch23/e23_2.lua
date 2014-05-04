--[[
Write a function that receives a date/time (coded as a number) and returns the number of seconds passed since the beginning of its respective day.
]]

function secondsinday(time)
  local start = os.date("*t", time)
  start.hour = 0
  start.min = 0
  start.sec = 0
  return time - os.time(start)
end

assert(secondsinday(os.time{year = 1970, month = 1, day = 1, hour = 0, min = 0, sec = 0}) == 0)
assert(secondsinday(os.time{year = 1977, month = 10, day = 23, hour = 0, min = 0, sec = 10}) == 10)
assert(secondsinday(os.time{year = 1986, month = 10, day = 21, hour = 7, min = 49, sec = 0}) == 7 * 3600 + 49 *60)

print("Seems to work!")
