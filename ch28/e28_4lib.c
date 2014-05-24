#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static const char *tablekey = "e28_5lib_trans";

static int settrans(lua_State *L) {
  lua_pushstring(L, tablekey);
  lua_insert(L, 1);
  lua_settable(L, LUA_REGISTRYINDEX);

  return 0;
}

static int gettrans(lua_State *L) {
  lua_pushstring(L, tablekey);
  lua_gettable(L, LUA_REGISTRYINDEX);

  return 1;
}

static int transliterate(lua_State *L) {
  size_t sourcelen;
  size_t i;
  const char *source =  luaL_checklstring(L, 1, &sourcelen);

  lua_pushstring(L, tablekey);
  lua_gettable(L, LUA_REGISTRYINDEX);

  luaL_Buffer resultbuffer;
  char *result = luaL_buffinitsize(L, &resultbuffer, sourcelen);

  for(i = 0; i < sourcelen; i++) {
    luaL_Buffer argbuffer;
    char *arg = luaL_buffinitsize(L, &argbuffer, 1);
    luaL_addchar(&argbuffer, source[i]);

    luaL_pushresult(&argbuffer);
    lua_gettable(L, 2);

    if(!lua_isboolean(L, -1) && !lua_isnil(L, -1)) {
      const char *newchar = luaL_checkstring(L, -1);
      luaL_addchar(&resultbuffer, newchar[0]);
    }

    lua_pop(L, 1);
  }

  luaL_pushresult(&resultbuffer);

  return 1;
}

static const struct luaL_Reg lib[] = {
  {"settrans", settrans},
  {"gettrans", gettrans},
  {"transliterate", transliterate},
  {NULL, NULL}
};

int luaopen_e28_4lib(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
