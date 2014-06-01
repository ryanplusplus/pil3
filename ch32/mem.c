#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

typedef struct {
  size_t limit;
  lua_Alloc wrappedAllocator;
  void *ud;
  lua_State *L;
} MemData;

static MemData * getself(lua_State *L) {
  MemData *self;
  lua_getfield(L, LUA_REGISTRYINDEX, "Mem_Self");
  self = (MemData *)lua_touserdata(L, -1);
  lua_pop(L, 1);
  return self;
}

static void * limit_alloc(void *ud, void *ptr, size_t osize, size_t nsize) {
  MemData *self = (MemData *)ud;

  size_t current = lua_gc(self->L, LUA_GCCOUNT, 0) * 1024 + lua_gc(self->L, LUA_GCCOUNTB, 0);

  if((self->limit == 0) || (nsize <= osize) || ((nsize - osize) + current) <= self->limit) {
    return self->wrappedAllocator(self->ud, ptr, osize, nsize);
  }
  else {
    return NULL;
  }
}

static int setlimit(lua_State *L) {
  MemData *self = getself(L);
  self->limit = luaL_checkint(L, 1);
  return 0;
}

static int finalize(lua_State *L) {
  MemData *self = getself(L);
  lua_setallocf(L, self->wrappedAllocator, self->ud);
  return 0;
}

static const struct luaL_Reg meta[] = {
  {"__gc", finalize},
  {NULL, NULL}
};

static const struct luaL_Reg lib[] = {
  {"setlimit", setlimit},
  {NULL, NULL}
};

int luaopen_mem(lua_State *L) {
  MemData *self;

  // Create a metatable so that we can finalize this library and set the alloc function back
  luaL_newmetatable(L, "Mem");
  lua_pushvalue(L, -1);
  lua_setfield(L, -2, "__index");
  luaL_setfuncs(L, meta, 0);

  // Create the library state, store it in the registry, and then set the metatable so that we can finalize
  self = (MemData *)lua_newuserdata(L, sizeof(MemData));
  lua_pushvalue(L, -1);
  lua_setfield(L, LUA_REGISTRYINDEX, "Mem_Self");
  luaL_getmetatable(L, "Mem");
  lua_setmetatable(L, -2);

  // Set up library state
  self->L = L;
  self->limit = 0;
  self->wrappedAllocator = lua_getallocf(L, &self->ud);
  lua_setallocf(L, limit_alloc, self);

  luaL_newlib(L, lib);

  return 1;
}
