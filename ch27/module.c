#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static int cont(lua_State *L) {
  while(lua_next(L, 1) != 0) {
    /* copy the function and move it below so that it remains after the call */
    lua_pushvalue(L, -3);
    lua_insert(L, -4);

    /* copy the key and move it below the function so that it remains after the call */
    lua_pushvalue(L, -2);
    lua_insert(L, -4);

    /* call the function (index -3) with 'key' (at index -2) and 'value' (at index -1) */
    lua_callk(L, 2, 0, 0, cont);
  }

  return 0;
}

static int foreach(lua_State *L) {
  /* first key */
  lua_pushnil(L);

  return cont(L);
}

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

static int reverse(lua_State *L) {
  int count = lua_gettop(L);
  int i;

  for(i = count; i >= 1; i--) {
    lua_pushvalue(L, i);
  }

  return count;
}

static const struct luaL_Reg lib[] = {
  {"foreach", foreach},
  {"summation", summation},
  {"pack", pack},
  {"reverse", reverse},
  {NULL, NULL}
};

int luaopen_module(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
