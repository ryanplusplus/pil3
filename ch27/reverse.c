#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static int reverse(lua_State *L) {
  int count = lua_gettop(L);
  int i;

  for(i = count; i >= 1; i--) {
    lua_pushvalue(L, i);
  }

  return count;
}

static const struct luaL_Reg lib[] = {
  {"reverse", reverse},
  {NULL, NULL}
};

int luaopen_reverse(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
