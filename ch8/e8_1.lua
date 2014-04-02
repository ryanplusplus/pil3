--[[
This is awkward, but as far as I can tell this is what it's supposed to do.
]]

function loadwithprefix(prefix, chunk)
  local prefix_read = false
  local string_read = false

  function reader_with_prefix()
    if not prefix_read then
      prefix_read = true
      return prefix
    else
      if type(chunk) == "string" then
        if not string_read then
          string_read = true
          return chunk
        else
          return nil
        end
      else
        return chunk()
      end
    end
  end

  return load(reader_with_prefix)
end

function dummy_reader()
  local lines = { "print('1')", "print('2')" }
  local i = 0

  return function()
    i = i + 1
    return lines[i]
  end
end

loadwithprefix("print('0')", dummy_reader())()
--[[
0
1
2
]]

loadwithprefix("print('0')", "print('1')")()
--[[
0
1
]]
