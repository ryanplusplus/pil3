#include <dirent.h>
#include <errno.h>
#include <string.h>

#include "lua.h"
#include "lauxlib.h"

static int dir_gc(lua_State *L) {
  DIR **d = (DIR **)lua_touserdata(L, 1);
  if(*d) {
    closedir(*d);
    *d = NULL;
  }

  return 0;
}

static int dir_iter(lua_State *L) {
  DIR **d = (DIR **)lua_touserdata(L, lua_upvalueindex(1));
  struct dirent *entry;
  if(*d) {
    if((entry = readdir(*d)) != NULL) {
      lua_pushstring(L, entry->d_name);
      return 1;
    }
    else {
      closedir(*d);
      *d = NULL;
    }
  }
  return 0;
}

static int l_dir(lua_State *L) {
  const char *path = luaL_checkstring(L, 1);

  DIR **d = (DIR **)lua_newuserdata(L, sizeof(DIR *));

  luaL_getmetatable(L, "LuaBook.dir");
  lua_setmetatable(L, -2);

  *d = opendir(path);
  if(*d == NULL) {
    luaL_error(L, "cannot open %s: %s", path, strerror(errno));
  }

  lua_pushcclosure(L, dir_iter, 1);

  return 1;
}

static const struct luaL_Reg dirlib[] = {
  {"open", l_dir},
  {NULL, NULL}
};

int luaopen_dir(lua_State *L) {
  luaL_newmetatable(L, "LuaBook.dir");

  lua_pushcfunction(L, dir_gc);
  lua_setfield(L, -2, "__gc");

  luaL_newlib(L, dirlib);

  return 1;
}
