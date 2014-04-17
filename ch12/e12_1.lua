--[[
Modify the code in Listing 12.2 so that it indents nested tables.  (Hint: add an extra parameter to serialize with the indentation string.)
]]

function serialize(o, indent)
  local function aux(o, indent)
    indent = indent or ""

    if type(o) == "number" then
      io.write(o)
    elseif type(o) == "string" then
      io.write(string.format("%q", o))
    elseif type(o) == "table" then
      io.write("{\n")

      for k, v in pairs(o) do
        io.write(indent .. "  ", k, " = ")
        aux(v, indent .. "  ")
        io.write(",\n")
      end

      io.write(indent .. "}")
    else
      error("cannot serialize a " .. type(o))
    end
  end

  --[[
  The original version didn't properly add a newline after numbers or strings.  This change ensures that we always end with a newline and don't put the ',' on a newline for nested tables.
  ]]
  aux(o, indent)
  io.write("\n")
end

serialize{1,2,3}
--[[
{
  1 = 1,
  2 = 2,
  3 = 3,
}
]]

serialize{{c = 1, d = 2, k = {v, 4}}, e = 4}
--[[
{
  1 = {
    d = 2,
    c = 1,
    k = {
      2 = 4,
    },
  },
  e = 4,
}
]]
