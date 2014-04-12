f = function() return error end
first = pcall(pcall(f))
print(first) --> false
