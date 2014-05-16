--[[
Write a summation function, in C, that computes the sum of its variable number of numeric arguments:

print(summation()) --> 0
print(summation(2.3, 5.4)) --> 7.7
print(summation(2.3, 5.4, -34)) --> -26.3
print(summation(2.3, 5.4, {})) --> stdin:1: bad argument #3 to 'summation' (number expected, got table)
]]

summation = (require 'summation').summation

print(summation()) --> 0
print(summation(2.3, 5.4)) --> 7.7
print(summation(2.3, 5.4, -34)) --> -26.3
print(summation(2.3, 5.4, {})) --> lua: e27_1.lua:15: bad argument #3 to 'summation' (number expected, got table)...
