--[[
The approach of avoiding constructors when saving tables with cycles is too radical.  It is possible to save the table in a more pleasant format using constructors for the general case, and to use assignments later only to fix sharing and loops.

Reimplement function save using this approach.  Add to it all the goodies that you have implemented in the previous exercises (indentation, record syntax, and list syntax).
]]

function basicSerialize(o)
  if type(o) == "number" then
    return tostring(o)
  elseif type(o) == "string" then
    return string.format("%q", o)
  end
end

function serialize(name, topvalue, saved)
  local function valid_identifier(k)
    -- Nifty little trick and a lot easier than trying to do the work that Lua already does
    return load(tostring(k) .. "= 1") and true or false
  end

  saved = saved or {}
  selfreferences = {}

  local function aux(name, value, indent)
    indent = indent or ""

    if type(value) == "number" or type(value) == "string" then
      io.write(basicSerialize(value))
    elseif type(value) == "table" then
      if saved[value] then
        io.write(saved[value])
      else
        saved[value] = name

        io.write("{\n")

        -- Array part
        for i, v in ipairs(value) do
          if v ~= topvalue then

            local fname = string.format("%s[%s]", name, i)
            io.write(indent .. "  "); aux(fname, v, indent .. "  "); io.write(",\n")
          else
            selfreferences[#selfreferences + 1] = tostring(i)
          end
        end

        -- Everything else
        for k, v in pairs(value) do
          if type(k) ~= "number" or k > #value then
            local fname

            if valid_identifier(k) then
              fname = tostring(k)
            else
              fname = string.format("[\"%s\"]", k)
            end

            if v ~= topvalue then
              io.write(indent .. "  " .. fname .. " = ")
              aux(name .. fname, v, indent .. "  ")
              io.write(",\n")
            else
              selfreferences[#selfreferences + 1] = fname
            end
          end
        end

        io.write(indent .. "}")
      end
    else
      error("cannot serialize a " .. type(value))
    end
  end

  io.write(name, " = ")
  aux(name, topvalue)

  io.write("\n")

  for _, v in ipairs(selfreferences) do
    io.write(name .. "[" .. v .. "] = " .. name .. "\n")
  end
end

c = {5,6,4}
b = {1,2,3}
a = {
  -- Array
  "first",
  {"second"},

  -- Valid identifier
  c = 3,

  -- Invalid identifier
  ["for"] = 4,
  [5] = 5,

  -- Duplicated reference
  [7] = c,
  [6] = c,

  -- Saved reference
  b = b
}

-- Self-reference, cycle not in array section
a["self"] = a

-- Self-reference, cycle in array section
a[3] = a

local saved = {}

-- Just want to make sure this gets saved
serialize("b", b, saved)
--[[
b = {
  1,
  2,
  3,
}
]]

-- Now make sure we handle all the crazy stuff
serialize("a", a, saved)
--[[
a = {
  "first",
  {
    "second",
  },
  ["for"] = 4,
  c = 3,
  b = b,
}
a[3] = a
a[self] = a
]]
