#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static int summation(lua_State *L) {
  double sum = 0;
  int count = lua_gettop(L);
  int i;

  for(i = 1; i <= count; i++) {
    sum += luaL_checknumber(L, i);
  }

  lua_pushnumber(L, sum);

  return 1;
}

static const struct luaL_Reg lib[] = {
  {"summation", summation},
  {NULL, NULL}
};

int luaopen_summation(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
