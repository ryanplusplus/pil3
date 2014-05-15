--[[
Let us suppose a program that needs to monitor several weather stations.  Internally, it uses a four-byte string to represent each station, and there is a configuration file to map each string to the actual URL of the corresponding station.  A Lua configuration file could do this mapping in several ways:

  * a bunch of global variables, one for each station;
  * one table mapping string codes to URLs;
  * one function mapping string codes to URLs.

Discuss the pros and cons of each option, considering things like the total number of stations, the regularity of the URLs (e.g. there may be a formation rule from codes to URLs), the kind of users, etc.
]]

--[[
A bunch of global variables
+ Simple to set up (usable even if someone knows nothing about Lua)
- Not scalable
- If the URLs are regular there will be a lot of duplication

A table or a function (identical in practice because of __index)
+ Can generate URLs based upon rules (may not even need to know what stations exist beforehand)
+ Can be used in essentially the same way as a bunch of global variables
- Lots of boilerplate if there are very few stations
- Requires users to understand some of the intricacies of Lua to take full advantage
]]
