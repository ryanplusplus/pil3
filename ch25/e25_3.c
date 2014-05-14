/*
Use the simple stand-alone interpreter (Listing 25.1) and the stackDump function (Listing 25.2) to check your answer to the previous exercise.
*/

#include <stdio.h>
#include <string.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static void stackDump(lua_State *L) {
  int i;
  int top = lua_gettop(L);
  for(i = 1; i <= top; i++) {
    int t = lua_type(L, i);
    switch(t) {
      case LUA_TSTRING: {
        printf("'%s'", lua_tostring(L, i));
        break;
      }

      case LUA_TBOOLEAN: {
        printf(lua_toboolean(L, i) ? "true" : "false");
        break;
      }

      case LUA_TNUMBER: {
        printf("%g", lua_tonumber(L, i));
        break;
      }

      default: {
        printf("%s", lua_typename(L, t));
        break;
      }
    }

    printf(" ");
  }

  printf("\n");
}

int main(void) {
  lua_State *L = luaL_newstate();

  lua_pushnumber(L, 3.5);
  lua_pushstring(L, "hello");
  lua_pushnil(L);
  lua_pushvalue(L, -2);
  lua_remove(L, 1);
  lua_insert(L, -2);

  stackDump(L);

  lua_close(L);
  return 0;
}

/*
$ gcc -o e25_3 e25_3.c -llua; ./e25_3
'hello' 'hello' nil
*/
