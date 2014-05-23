#include <string.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static int l_split(lua_State *L) {
  size_t len;
  const char *subject =  luaL_checklstring(L, 1, &len);
  const char *separator = luaL_checkstring(L, 2);
  const char *element;
  int i = 1;

  lua_newtable(L);

  // Get every substring that is terminated by a separator
  while((element = memchr(subject, *separator, len)) != NULL) {
    lua_pushlstring(L, subject, element - subject);
    lua_rawseti(L, -2, i++);
    len -= ((size_t)element - (size_t)subject) + 1;
    subject = element + 1;
  }

  // Insert whatever's left
  lua_pushlstring(L, subject, len);
  lua_rawseti(L, -2, i);

  return 1;
}

static const struct luaL_Reg lib[] = {
  {"l_split", l_split},
  {NULL, NULL}
};

int luaopen_l_split(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
