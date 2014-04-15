--[=[
How can you embed the following piece of XML as a string in Lua?

<![CDATA[
  Hello world
]]>
]=]

local xml1 = [=[
<![CDATA[
  Hello world
]]>]=]

local xml2 = "<![CDATA[\n  Hello world\n]]>"

print(xml1)
print(xml2)
