#include <limits.h>
#include <string.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

#define BITS_PER_WORD (CHAR_BIT * sizeof(unsigned int))
#define I_WORD(i) ((unsigned int)(i) / BITS_PER_WORD)
#define I_BIT(i) (1 << ((unsigned int)(i) % BITS_PER_WORD))

typedef struct NumArray {
  int size;
  unsigned int values[1];
} NumArray;

#define checkarray(L, i) (NumArray *)luaL_checkudata(L, i, "LuaBook.array")

static size_t getnbytes(int n) {
  return sizeof(NumArray) + I_WORD(n - 1) * sizeof(unsigned int);
}

static int getbit(NumArray *a, int index) {
  return a->values[I_WORD(index)] & I_BIT(index);
}

static void setbit(NumArray *a, int index, int value) {
  if(value) {
    a->values[I_WORD(index)] |= I_BIT(index);
  }
  else {
    a->values[I_WORD(index)] &= ~I_BIT(index);
  }
}

static void createarray(lua_State *L, int n) {
  int i;
  size_t nbytes;
  NumArray *a;

  nbytes = getnbytes(n);
  a = (NumArray *)lua_newuserdata(L, nbytes);

  luaL_getmetatable(L, "LuaBook.array");
  lua_setmetatable(L, -2);

  a->size = n;
  for(i = 0; i <= I_WORD(n - 1); i++) {
    a->values[i] = 0;
  }
}

static int newarray(lua_State *L) {
  int n = luaL_checkint(L, 1);
  luaL_argcheck(L, n >= 1, 1, "invalid size");
  createarray(L, n);

  return 1;
}

static int setarray(lua_State *L) {
  NumArray *a = checkarray(L, 1);
  int index = luaL_checkint(L, 2) - 1;

  luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");
  luaL_argcheck(L, lua_isboolean(L, 3), 3, "boolean expected");

  setbit(a, index, lua_toboolean(L, 3));

  return 0;
}

static int getarray(lua_State *L) {
  NumArray *a = checkarray(L, 1);
  int index = luaL_checkint(L, 2) - 1;

  luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");

  lua_pushboolean(L, getbit(a, index));

  return 1;
}

static int getsize(lua_State *L) {
  NumArray *a = checkarray(L, 1);
  luaL_argcheck(L, a != NULL, 1, "'array' expected");
  lua_pushinteger(L, a->size);

  return 1;
}

static int getunion(lua_State *L) {
  int i;
  int resultsize;
  NumArray *largest;
  NumArray *result;

  NumArray *a1 = checkarray(L, 1);
  NumArray *a2 = checkarray(L, 2);

  largest = a1->size > a2-> size ? a1 : a2;
  resultsize = largest->size;

  createarray(L, resultsize);
  result = (NumArray *)lua_touserdata(L, -1);

  memcpy(result->values, largest->values, getnbytes(resultsize));

  for(i = 0; (i < a1->size) && (i < a2->size ); i++) {
    setbit(result, i, getbit(a1, i) || getbit(a2, i));
  }

  return 1;
}

static int getintersection(lua_State *L) {
  int i;
  int resultsize;
  NumArray *largest;
  NumArray *result;

  NumArray *a1 = checkarray(L, 1);
  NumArray *a2 = checkarray(L, 2);

  largest = a1->size > a2-> size ? a1 : a2;
  resultsize = largest->size;

  createarray(L, resultsize);
  result = (NumArray *)lua_touserdata(L, -1);

  for(i = 0; (i < a1->size) && (i < a2->size ); i++) {
    setbit(result, i, getbit(a1, i) && getbit(a2, i));
  }

  return 1;
}

static int tostring(lua_State *L) {
  NumArray *a = checkarray(L, 1);
  int i;
  luaL_Buffer stringbuffer;

  luaL_buffinit(L, &stringbuffer);

  for(i = 0; i < a-> size; i++) {
    luaL_addchar(&stringbuffer, getbit(a, i) ? '1' : '0');
  }

  luaL_pushresult(&stringbuffer);

  return 1;
}

static const struct luaL_Reg lib_f[] = {
  {"new", newarray},
  {"union", getunion},
  {"intersection", getintersection},
  {NULL, NULL}
};

static const struct luaL_Reg lib_m[] = {
  {"__tostring", tostring},
  {"set", setarray},
  {"get", getarray},
  {"size", getsize},
  {NULL, NULL}
};

int luaopen_array(lua_State *L) {
  luaL_newmetatable(L, "LuaBook.array");

  lua_pushvalue(L, -1);
  lua_setfield(L, -2, "__index");

  luaL_setfuncs(L, lib_m, 0);

  luaL_newlib(L, lib_f);

  return 1;
}
