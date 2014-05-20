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

static const struct luaL_Reg lib[] = {
  {"foreach", foreach},
  {NULL, NULL}
};

int luaopen_foreachcont(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
