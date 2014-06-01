#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static int yield(lua_State *L) {
  lua_pushstring(L, "the answer to life, the universe and everything");
  lua_pushinteger(L, 42);
  return lua_yield(L, 2);
}

static const struct luaL_Reg lib[] = {
  {"yield", yield},
  {NULL, NULL}
};

int luaopen_yieldtest(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
