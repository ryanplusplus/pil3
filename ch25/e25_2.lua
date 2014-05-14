--[[
Assume the stack is empty.  What will be its contents after the following sequence of calls?

lua_pushnumber(L, 3.5);
lua_pushstring(L, "hello");
lua_pushnil(L);
lua_pushvalue(L, -2);
lua_remove(L, 1);
lua_insert(L, -2);
]]

--[[
lua_pushnumber(L, 3.5);
[
  1 -> 3.5
]

lua_pushstring(L, "hello");
[
  1 -> 3.5
  2 -> 'hello'
]

lua_pushnil(L);
[
  1 -> 3.5
  2 -> 'hello'
  3 -> nil
]

lua_pushvalue(L, -2);
[
  1 -> 3.5
  2 -> 'hello'
  3 -> nil
  4 -> 'hello'
]

lua_remove(L, 1);
[
  1 -> 'hello'
  2 -> nil
  3 -> 'hello'
]

lua_insert(L, -2);
[
  1 -> 'hello'
  2 -> 'hello'
  3 -> nil
]
]]
