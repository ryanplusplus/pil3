--[[
Modify the queue implementation so that both indices return to zero when the queue is empty.
]]

List = {}

function List.new()
  return {first = 0, last = -1}
end

function List.pushfirst(list, value)
  local first = list.first - 1
  list.first = first
  list[first] = value
end

function List.pushlast(list, value)
  local last = list.last + 1
  list.last = last
  list[last] = value
end

function List.popfirst(list)
  local first = list.first
  if first > list.last then error("list is empty") end
  local value = list[first]
  list[first] = nil
  list.first = first + 1
  if list.first == list.last + 1 then list.first = 0; list.last = -1 end
  return value
end

function List.poplast(list)
  local last = list.last
  if list.first > last then error("list is empty") end
  local value = list[last]
  list[last] = nil
  list.last = last - 1
  if list.first == list.last + 1 then list.first = 0; list.last = -1 end
  return value
end

function printlist(list)
  local sb = {'{'}

  for i = list.first, list.last do
    sb[#sb + 1] = list[i]
  end

  sb[#sb + 1] = '}'

  print(table.concat(sb, " "))
end

l = List.new()

List.pushfirst(l, 2)
List.pushfirst(l, 1)
List.pushlast(l, 3)

printlist(l) --> { 1 2 3 }
print(l.first) --> -2
print(l.last) --> 0

List.popfirst(l)
List.poplast(l)
List.poplast(l)

printlist(l) --> { }
print(l.first) --> 0
print(l.last) --> -1

List.pushfirst(l, 1)
List.popfirst(l)

printlist(l) --> { }
print(l.first) --> 0
print(l.last) --> -1
