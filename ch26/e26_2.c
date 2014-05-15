/*
Modify function call_va (Listing 26.5) to handle boolean values.
*/

#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdbool.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static void call_va(lua_State *L, const char *func, const char *sig, ...) {
  va_list vl;
  int narg, nres;

  va_start(vl, sig);
  lua_getglobal(L, func);
  for(narg = 0; *sig; narg++) {
    luaL_checkstack(L, 1, "too many arguments");

    switch(*sig++) {
      case 'b':
        lua_pushboolean(L, va_arg(vl, int));
        break;

      case 'd':
        lua_pushnumber(L, va_arg(vl, double));
        break;

      case 'i':
        lua_pushinteger(L, va_arg(vl, int));
        break;

      case 's':
        lua_pushstring(L, va_arg(vl, char *));
        break;

      case '>':
        goto endargs;

      default:
        printf("invalid arg signature\n");
        exit(-1);
    }
  }

  endargs:

  nres = strlen(sig);

  if(lua_pcall(L, narg, nres, 0) != 0) {
    exit(-1);
  }

  nres = -nres;

  while(*sig) {
    switch(*sig++) {
      case 'b': {
        bool b = lua_toboolean(L, nres);
        *va_arg(vl, bool *) = b;
        break;
      }

      case 'd': {
        int isnum;
        double n = lua_tonumberx(L, nres, &isnum);
        if(!isnum) {
          printf("expected num, didn't get one\n");
          exit(-1);
        }
        *va_arg(vl, double *) = n;
        break;
      }

      case 'i': {
        int isnum;
        int n = lua_tointegerx(L, nres, &isnum);
        if(!isnum) {
          printf("expected num, didn't get one\n");
          exit(-1);
        }
        *va_arg(vl, int *) = n;
        break;
      }

      case 's': {
        const char *s = lua_tostring(L, nres);
        if(s == NULL) {
          printf("expected string, didn't get one\n");
          exit(-1);
        }
        *va_arg(vl, const char **) = s;
        break;
      }

      default:
        printf("invalid result sig\n");
        exit(-1);
    }

    nres++;
  }

  va_end(vl);
}

int main(int argc, char *argv[]) {
  lua_State *L = luaL_newstate();

  luaL_loadstring(L, "function f(x, y) return x and y end");
  lua_pcall(L, 0, 0, 0);

  bool result;
  call_va(L, "f", "bb>b", true, true, &result);
  printf("%d\n", result);
  call_va(L, "f", "bb>b", false, true, &result);
  printf("%d\n", result);
  call_va(L, "f", "bb>b", true, false, &result);
  printf("%d\n", result);
  call_va(L, "f", "bb>b", false, false, &result);
  printf("%d\n", result);

  return 0;
}

/*
$ gcc e26_2.c -llua; ./a.out; rm a.out
1
0
0
0
*/
