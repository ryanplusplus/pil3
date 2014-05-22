#include <stdbool.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

enum
{
  list_index = 1,
  predicate_index,
  result_index
};

static int filter(lua_State *L) {
  luaL_checktype(L, list_index, LUA_TTABLE);
  luaL_checktype(L, predicate_index, LUA_TFUNCTION);
  lua_newtable(L);

  {
    int result_key = 1;
    int list_len;
    int i;

    lua_len(L, list_index);
    list_len = lua_tointeger(L, -1);
    lua_pop(L, 1);

    for(i = 1; i <= list_len; i++) {
      bool predicate_result;

      lua_pushvalue(L, predicate_index);
      lua_rawgeti(L, list_index, i);
      lua_call(L, 1, 1);
      predicate_result = lua_toboolean(L, -1);
      lua_pop(L, 1);

      if(predicate_result) {
        lua_rawgeti(L, list_index, i);
        lua_rawseti(L, result_index, result_key++);
      }
    }
  }

  return 1;
}

static const struct luaL_Reg lib[] = {
  {"filter", filter},
  {NULL, NULL}
};

int luaopen_filter(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
