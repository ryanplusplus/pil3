#include <limits.h>
#include <string.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

typedef struct {
  int size;
  int values[1];
} IntegerArray;

#define checkintegerarray(L, i) (IntegerArray *)luaL_checkudata(L, i, "LuaBook.integerarray")

static size_t getnbytes(int n) {
  return offsetof(IntegerArray, values) + n;
}

static void createarray(lua_State *L, int n) {
  int i;
  size_t nbytes;
  IntegerArray *a;

  nbytes = getnbytes(n);
  a = (IntegerArray *)lua_newuserdata(L, nbytes);

  luaL_getmetatable(L, "LuaBook.integerarray");
  lua_setmetatable(L, -2);

  a->size = n;
  for(i = 0; i < n; i++) {
    a->values[i] = 0;
  }
}

static int _new(lua_State *L) {
  int n = luaL_checkint(L, 1);
  luaL_argcheck(L, n >= 1, 1, "invalid size");
  createarray(L, n);

  return 1;
}

static int set(lua_State *L) {
  IntegerArray *a = checkintegerarray(L, 1);
  int index = luaL_checkint(L, 2) - 1;

  luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");

  a->values[index] = lua_tointeger(L, 3);

  return 0;
}

static int get(lua_State *L) {
  IntegerArray *a = checkintegerarray(L, 1);
  int index = luaL_checkint(L, 2) - 1;

  luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");
  lua_pushinteger(L, a->values[index]);

  return 1;
}

static int size(lua_State *L) {
  IntegerArray *a = checkintegerarray(L, 1);
  luaL_argcheck(L, a != NULL, 1, "'integerarray' expected");
  lua_pushinteger(L, a->size);

  return 1;
}

static int tostring(lua_State *L) {
  IntegerArray *a = checkintegerarray(L, 1);
  int i;
  luaL_Buffer stringbuffer;

  luaL_buffinit(L, &stringbuffer);

  luaL_addstring(&stringbuffer, "{ ");

  for(i = 0; i < a->size; i++) {
    char buffer[20];
    sprintf(buffer, "%d", a->values[i]);
    luaL_addstring(&stringbuffer, buffer);

    if(i < a->size - 1) {
      luaL_addchar(&stringbuffer, ',');
    }

    luaL_addchar(&stringbuffer, ' ');
  }

  luaL_addstring(&stringbuffer, "}");

  luaL_pushresult(&stringbuffer);

  return 1;
}

static const struct luaL_Reg lib_f[] = {
  {"new", _new},
  {NULL, NULL}
};

static const struct luaL_Reg lib_m[] = {
  {"__tostring", tostring},
  {"set", set},
  {"get", get},
  {"size", size},
  {NULL, NULL}
};

int luaopen_integerarray(lua_State *L) {
  luaL_newmetatable(L, "LuaBook.integerarray");

  lua_pushvalue(L, -1);
  lua_setfield(L, -2, "__index");

  luaL_setfuncs(L, lib_m, 0);

  luaL_newlib(L, lib_f);

  return 1;
}
