function multiload(...)
  local args = {...}

  function map(f, l)
    local mapped = {}
    for i, v in ipairs(l) do mapped[i] = f(v) end
    return mapped
  end

  function create_reader(chunk)
    if type(chunk) == "string" then
      local done = false
      return function()
        if not done then
          done = true
          return chunk
        else
          return nil
        end
      end
    else
      return chunk
    end
  end

  local readers = map(create_reader, args)
  local i = 1

  function multireader()
    if not readers[i] then return nil end

    local s = readers[i]()
    if s then
      return s
    else
      i = i + 1
      return multireader()
    end
  end

  return load(multireader)
end

function dummy_reader()
  local lines = { "print('1')", "print('2')" }
  local i = 0

  return function()
    i = i + 1
    return lines[i]
  end
end

multiload("print('0')", dummy_reader(), "print('3')")()
--[[
0
1
2
3
]]
