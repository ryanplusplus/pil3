/*
Write a C proram that reads a Lua file defining a function f from numbers to numbers and plots that function.  (You do not need to do anything fancy the program can plot the results printing ASCII asterisks as we did in Section 8.1.)
*/

#include <stdio.h>
#include <string.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

int main(int argc, char *argv[]) {
  lua_State *L = luaL_newstate();

  luaL_loadfile(L, argv[1]);
  lua_pcall(L, 0, 0, 0);

  for(int i = 0; i < 20; i++) {
    lua_getglobal(L, "f");
    lua_pushnumber(L, i);
    lua_pcall(L, 1, 1, 0);
    double result = lua_tonumber(L, -1);

    for(int j = 0; j < (int)result; j++) {
      printf("*");
    }
    printf("\n");
  }

  lua_close(L);
  return 0;
}
