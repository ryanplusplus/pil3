#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static int transliterate(lua_State *L) {
  size_t sourcelen;
  size_t i;
  const char *source =  luaL_checklstring(L, 1, &sourcelen);

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
  {"transliterate", transliterate},
  {NULL, NULL}
};

int luaopen_transliterate(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
