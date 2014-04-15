--[[
Function stringrep, in Listing 8.2, uses a binary multiplication algorithm to concatenate n copies of a given string s.  For any fixed n, we can create a specialized version of stringrep by unrolling the loop into a sequence of instructions r=r..s and s=s..s.  As an example, for n=5, the unrolling gives us the following function:

function stringrep_5(s)
  local r = ""
  r = r .. s
  s = s .. s
  s = s .. s
  r = r .. s
  return r
end

Write a function that, given n, returns a specialized function stringrep_n.  Instead of using a closure, your function should build the text of a Lua function with the proper sequence of instructions (r=r..s and s=s..s) and then use load to produce the final function.  Compare the performance of the generic function stringrep (or of a closure using it) with your tailor-made functions.
]]

function stringrep(s, n)
  local r = ""

  if n > 0 then
    while n > 1 do
      if n % 2 ~= 0 then r = r..s end
      s = s .. s
      n = math.floor(n / 2)
    end

    r = r .. s
  end

  return r
end

function stringrepgenerator(n)
  local thing = "function(s)"
  local body = "local r = '';"-- r = r .. s; s = s .. s; s = s .. s; r = r .. s; return r;"

  if n > 0 then
    while n > 1 do
      if n % 2 ~= 0 then body = body .. "r = r..s;" end
      body = body .. "s = s .. s;"
      n = math.floor(n / 2)
    end

    body = body .. "r = r .. s;"
  end

  return load("return function(s) " .. body .. "return r end")()
end

function repeated(f, times)
  return function()
    for i = 1, times do f() end
  end
end

function time(f)
  start = os.clock()
  f()
  finish = os.clock()
  print("elapsed time: " .. tostring(finish - start) .. "s")
end

function benchmark(f, times)
  time(repeated(f, times))
end

stringrep_5 = stringrepgenerator(5)

benchmark((function() stringrep("abc", 5) end), 10000000)
--> elapsed time: 6.77187s

benchmark((function() stringrep_5("abc") end), 10000000)
--> elapsed time: elapsed time: 3.570399s
