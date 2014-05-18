--[[
Write a function that receives any number of parameters and returns them in reverse order.

print(reverse(1, "hello", 20)) --> 20 hello 1
]]

reverse = (require 'reverse').reverse

print(reverse(1, "hello", 20)) --> 20 hello 1
