--[[
Write a library that allows a script to limit the total amount of memory used by its Lua state.  It may offer a single function, setlimit, to set that limit.

The library should set its own allocation function.  This function, before calling the original allocator, checks the total memory in use and returns NULL if the requested memory exceeds the limit.

(Hint: the library can use lua_gc to initialize its byte count when it starts.  It also can use the user data of the allocation function to keep its state: the byte count, the current memory limit, etc.; remember to use the original user data when calling the original allocation function.)
]]

mem = require 'mem'

mem.setlimit(26000)

t = {}
while true do
  t[#t + 1] = #t + 1
  print(t[#t])
end
--[[
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
lua: not enough memory
]]
