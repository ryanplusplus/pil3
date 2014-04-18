--[[
The approach of avoiding constructors when saving tables with cycles is too radical.  It is possible to save the table in a more pleasant format using constructors for the general case, and to use assignments later only to fix sharing and loops.

Reimplement function save using this approach.  Add to it all the goodies that you have implemented in the previous exercises (indentation, record syntax, and list syntax).
]]

function serialize(name, value, saved)
  local function valid_identifier(k)
    -- Nifty little trick and a lot easier than trying to do the work that Lua already does
    return load(tostring(k) .. "= 1") and true or false
  end

  --[[
  Keep track of both saved and in progress items so that we can inline references to fully-defined items and only queue assignments when the reference would not be valid.
  ]]
  saved = saved or {}
  inprogress = {}
  assignments = {}

  local function aux(name, value, indent)
    indent = indent or ""

    if type(value) == "number" then
      io.write(tostring(value))
    elseif type(value) == "string" then
      io.write(string.format("%q", value))
    elseif type(value) == "table" then
      if saved[value] then
        io.write(saved[value])
      else
        inprogress[value] = name

        io.write("{\n")

        -- Array part
        for i, v in ipairs(value) do
          if inprogress[v] then
            assignments[name .. "[" .. i .. "] = " .. inprogress[v]] = true
          else
            local fname = string.format("%s[%s]", name, i)
            io.write(indent .. "  "); aux(fname, v, indent .. "  "); io.write(",\n")
          end
        end

        -- Everything else
        for k, v in pairs(value) do
          if type(k) ~= "number" or k > #value then
            if inprogress[v] then
              assignments[string.format("%s[%s] = %s", name, k, inprogress[v])] = true
            else
              if valid_identifier(k) then
                io.write(indent .. "  " .. tostring(k) .. " = ")
                aux(string.format("%s[%s]", name, tostring(k)), v, indent .. "  ")
              else
                local dispname = string.format("[\"%s\"]", k)
                io.write(indent .. "  " .. dispname .. " = ")
                aux(name .. dispname, v, indent .. "  ")
              end

              io.write(",\n")
            end
          end
        end

        io.write(indent .. "}")

        inprogress[value] = nil
        saved[value] = name
      end
    else
      error("cannot serialize a " .. type(value))
    end
  end

  io.write(name, " = ")
  aux(name, value)

  io.write("\n")

  for v in pairs(assignments) do
    io.write(v .. "\n")
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

-- Self-reference, not the top-level item
a["cycle"] = {}
a["cycle"]["loopback"] = a["cycle"]

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
--[=[
a = {
  "first",
  {
    "second",
  },
  ["5"] = 5,
  ["6"] = {
    5,
    6,
    4,
  },
  ["7"] = a[["6"]],
  ["for"] = 4,
  b = b,
  c = 3,
  cycle = {
  },
}
a[3] = a
a[self] = a
a[cycle][loopback] = a[cycle]
]=]
