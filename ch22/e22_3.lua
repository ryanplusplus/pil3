--[[
Compare the performance of Lua programs that copy the standard input file to the standard output file in the following ways:
* byte by byte;
* line by line;
* in chunks of 8 kB;
* the whole file at once;
For the last option, how large can be the input file?
]]

local modes = {
  b = function()
    while true do
      local byte = io.read(1)
      if not byte then break end
      io.write(byte)
    end
  end,

  l = function()
    for line in io.lines() do
      print(line)
    end
  end,

  c = function()
    while true do
      local chunk = io.read(8 * 1024)
      if not chunk then break end
      io.write(chunk)
    end
  end,

  w = function()
    io.write(io.read("*a"))
  end
}

modes[arg[1]]()

--[[
For the benchmarks I used 10 megabytes of random data from /dev/random:

dd if=/dev/random of=./somefile bs=1m count=10

This theoretically gives us lines of 256 bytes on average.  This will presumably have some impact on the performance of the line by line mode, but I'm too lazy to dig further.
]]

--[[
time lua e22_3.lua "b" < somefile
...
real 0m10.161s
user 0m7.867s
sys 0m0.186s
]]

--[[
time lua e22_3.lua "l" < somefile
...
real 0m1.062s
user 0m0.051s
sys 0m0.087s
]]

--[[
time lua e22_3.lua "c" < somefile
...
real 0m2.488s
user 0m0.020s
sys 0m0.162s
]]

--[[
time lua e22_3.lua "w" < somefile
...
real 0m1.938s
user 0m0.017s
sys 0m0.174s
]]

--[[
I tested the whole file method up to 1 gb of data:

dd if=/dev/zero of=./somefile bs=1m count=1000
time lua e22_3.lua "w" < somefile
real 0m42.506s
user 0m0.783s
sys 0m25.261s

It was slow, but it worked.  Presumably this would continue to work until you ran out of physical memory.
]]
