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
