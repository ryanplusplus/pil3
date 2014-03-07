function array_printer_ipairs(a)
  for _, v in ipairs(a) do
    print(v)
  end
end

function array_printer_unpack(a)
  print(unpack(a))
end

array_printer_ipairs{5,3,2,1,5,3,2,4}
--[[
5
3
2
1
5
3
2
4
]]

array_printer_unpack{5,3,2,1,5,3,2,4}
--[[
5 3 2 1 5 3 2 4
]]
