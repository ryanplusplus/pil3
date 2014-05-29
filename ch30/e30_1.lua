--[[
Modify the dir_iter function in the directory example so that it closes the DIR structure when it reaches the end of the traversal.  With this change, the program does not need to wait for a garbage collection to release a resource that it knows it will not need anymore.

(When you close the directory, you should se tthe address stored in the userdatum to NULL, to signal to the finalizer that the directory is already closed.  Also, function dir_iter will ahve to check whether the directory is not closed before using it.)
]]

dir = require 'dir'

for fname in dir.open(".") do
  print(fname)
end
--[[
.
..
dir.c
dir.so
e30_1.lua
]]
