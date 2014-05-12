/*
Compile and run the simple stand-alone interpreter (Listing 25.1).
*/

#include <stdio.h>
#include <string.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

int main(void) {
  char buff[256];
  int error;
  lua_State *L = luaL_newstate();
  luaL_openlibs(L);
  while(fgets(buff, sizeof(buff), stdin) != NULL) {
    error = luaL_loadstring(L, buff) || lua_pcall(L, 0, 0, 0);
    if(error) {
      fprintf(stderr, "%s\n", lua_tostring(L, -1));
      lua_pop(L, 1);
    }
  }

  lua_close(L);
  return 0;
}

/*
$ gcc -o e25_1 e25_1.c -llua
$ ./e25_1
x=5
print(x)
5
pint(x)
[string "pint(x)..."]:1: attempt to call global 'pint' (a nil value)
*/
