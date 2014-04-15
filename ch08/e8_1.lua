--[[
Frequently, it is useful to add some prefix to a chunk of code when loading it. (We saw an example previously in this chapter, where we prefixed a return to an expression being loaded.) Write a function loadwithprefix that works like load, except that it adds its extra first argument (a string) as a prefix to the chunk being loaded.

Like the original load, loadwithprefix should accept chunks represented both as strings and as reader functions. Even in the case that the original chunk is a string, loadwithprefix should not actually concatenate the prefix with the chunk. Instead, it should call load with a proper reader function that first returns the prefix and then returns the original chunk.
]]

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
