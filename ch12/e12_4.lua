--[[
Modify the code of the previous exercise so that it uses the constructor syntax for lists whenever possible.  For instance, it should serialize the table {14, 15, 19} as {14, 15, 19}, not as {[1] = 14, [2] = 15, [3] = 19}.  (Hint: start by saving the values of keys 1, 2, ..., as long as they are not nil.  Take care not to save them again when traversing the rest of the table.)
]]

function serialize(o, indent)
  local function valid_identifier(k)
    -- Nifty little trick and a lot easier than trying to do the work that Lua already does
    return load(tostring(k) .. "= 1") and true or false
  end

  local function aux(o, indent)
    indent = indent or ""

    if type(o) == "number" then
      io.write(o)
    elseif type(o) == "string" then
      io.write(string.format("%q", o))
    elseif type(o) == "table" then
      io.write("{\n")

      for _, v in ipairs(o) do
        io.write(indent .. "  "); aux(v, indent .. "  ")
        io.write(",\n")
      end

      for k, v in pairs(o) do
        if type(k) ~= "number" or k > #o then
          if valid_identifier(k) then
            io.write(indent .. "  ", k, " = ")
          else
            io.write(indent .. "  ["); aux(k); io.write("] = ")
          end

          aux(v, indent .. "  ")
          io.write(",\n")
        end
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

serialize{"first", {"second"}, "third", a = 1, ["1b"] = 2, c = 3, ["for"] = 4, [5] = 5}
--[[
{
  "first",
  {
    "second",
  },
  "third",
  ["1b"] = 2,
  a = 1,
  [5] = 5,
  c = 3,
  ["for"] = 4,
}
]]
