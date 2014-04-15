--[[
The number 12.7 is equal to the fraction 127/10, where the denominator is a power of ten.  Can you express it as a common fraction where the denominator is a power of two?  What about the number 5.5?
]]

--[[
For a number to have a finite binary representation it has to be expressible as p/2^n for some p, n

12.7 == 127/10
To get a denominator of the form 2^n we need to divide out a 5
But, 127 % 5 != 0
=> 12.7 does not have an exact binary representation

5.5 == 11/2
p = 11, n = 1
=> 5.5 has an exact binary representation
]]
