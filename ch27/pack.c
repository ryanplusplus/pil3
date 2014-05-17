#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static int pack(lua_State *L) {
  int count = lua_gettop(L);
  int i;

  lua_newtable(L);
  for(i = 1; i <= count; i++) {
    lua_pushnumber(L, i);
    lua_pushvalue(L, i);
    lua_settable(L, -3);
  }

  return 1;
}

static const struct luaL_Reg lib[] = {
  {"pack", pack},
  {NULL, NULL}
};

int luaopen_pack(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
