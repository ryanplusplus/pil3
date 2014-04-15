--[[
What will the following script print?  Explain.

sunday = "monday"; monday = "sunday"
t = {sunday = "monday", [sunday] = monday}
print(t.sunday, t[sunday], t[t.sunday])
]]

sunday = "monday"
monday = "sunday"

t = {sunday = "monday", [sunday] = monday}
--[[
This is equivalent to:
t = {sunday = "monday", ["monday"] = "sunday"}

Which is equivalent to:
t = {sunday = "monday", monday = "sunday"}
]]

print(t.sunday, t[sunday], t[t.sunday])
--[[
This is equivalent to:
print("monday", t["monday"], t["monday"])

Which is equivalent to:
print("monday", t.monday, t.monday)

Which is equivalent to:
print("monday", "sunday", "sunday")
]]
