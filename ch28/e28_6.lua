--[[
Do you think it is a good design to keep the transliteration table as part of the state of the library, isntead of being a parameter to transliterate?
]]

--[[
No, this forces clients of the library to coordinate with each other to ensure that the hidden state still has its expected value.  Alternately, each client could set the state each time it uses the transliterate function, but this defeats the purpose of storing the state internally.

Instead, it would be better to use a quick closure to achieve the desired behavior:

function specializedtransliterate(t)
  return function(s) transliterate(s, t) end
end
]]
