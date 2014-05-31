#include <stdlib.h>
#include "expat.h"
#include "lua.h"
#include "lauxlib.h"

typedef struct {
  XML_Parser parser;
  int callbackRef;
  lua_State *L;
} lxp_userdata;

static void f_StartElement(void *ud, const char *name, const char **atts) {
  lxp_userdata *xpu = (lxp_userdata *)ud;
  lua_State *L = xpu->L;

  // Get the callback from the table
  lua_rawgeti(L, LUA_REGISTRYINDEX, xpu->callbackRef);
  lua_getfield(L, -1, "StartElement");
  lua_remove(L, -2);
  if(lua_isnil(L, -1)) {
    lua_pop(L, 1);
    return;
  }

  // Invoke the callback with the parser, the tag name, and a table of attributes
  lua_pushvalue(L, 1);
  lua_pushstring(L, name);
  lua_newtable(L);
  for(; *atts; atts += 2) {
    lua_pushstring(L, *(atts + 1));
    lua_setfield(L, -2, *atts);
  }
  lua_call(L, 3, 0);
}

static void f_CharData(void *ud, const char *s, int len) {
  lxp_userdata *xpu = (lxp_userdata *)ud;
  lua_State *L = xpu->L;

  // Get the callback from the table
  lua_rawgeti(L, LUA_REGISTRYINDEX, xpu->callbackRef);
  lua_getfield(L, -1, "CharacterData");
  lua_remove(L, -2);
  if(lua_isnil(L, -1)) {
    lua_pop(L, 1);
    return;
  }

  // Invoke the callback with the parser and the parsed text
  lua_pushvalue(L, 1);
  lua_pushlstring(L, s, len);
  lua_call(L, 2, 0);
}

static void f_EndElement(void *ud, const char *name) {
  lxp_userdata *xpu = (lxp_userdata *)ud;
  lua_State *L = xpu->L;

  // Get the callback from the table
  lua_rawgeti(L, LUA_REGISTRYINDEX, xpu->callbackRef);
  lua_getfield(L, -1, "EndElement");
  lua_remove(L, -2);
  if(lua_isnil(L, -1)) {
    lua_pop(L, 1);
    return;
  }

  // Invoke the callback with the parser and the parsed tag name
  lua_pushvalue(L, 1);
  lua_pushstring(L, name);
  lua_call(L, 2, 0);
}

static int lxp_make_parser(lua_State *L) {
  XML_Parser p;

  // Create the parser
  lxp_userdata *xpu = (lxp_userdata *)lua_newuserdata(L, sizeof(lxp_userdata));

  // Initialize to NULL in case we fail out -- this keeps the gc from puking
  xpu->parser = NULL;

  // Set the metatable so that it has all the lxp methods available
  luaL_getmetatable(L, "Expat");
  lua_setmetatable(L, -2);

  // Create the parser
  p = xpu->parser = XML_ParserCreate(NULL);
  if(!p) {
    luaL_error(L, "XML_ParserCreate failed");
  }

  // Store the callback table
  luaL_checktype(L, 1, LUA_TTABLE);
  lua_pushvalue(L, 1);
  xpu->callbackRef = luaL_ref(L, LUA_REGISTRYINDEX);

  // Configure parser
  XML_SetUserData(p, xpu);
  XML_SetElementHandler(p, f_StartElement, f_EndElement);
  XML_SetCharacterDataHandler(p, f_CharData);

  return 1;
}

static int lxp_parse(lua_State *L) {
  int status;
  size_t len;
  const char *s;
  lxp_userdata *xpu;

  // Make sure this is actually a parser
  xpu = (lxp_userdata *)luaL_checkudata(L, 1, "Expat");

  // Make sure parser hasn't already been closed
  luaL_argcheck(L, xpu->parser != NULL, 1, "parser is closed");

  // Get the string (XML) to parse
  s = luaL_optlstring(L, 2, NULL, &len);

  xpu->L = L;

  // Parse the string
  status = XML_Parse(xpu->parser, s, (int)len, s == NULL);

  // Return error code
  lua_pushboolean(L, status);

  return 1;
}

static int lxp_close(lua_State *L) {
  lxp_userdata *xpu = (lxp_userdata *)luaL_checkudata(L, 1, "Expat");

  if(xpu->parser) {
    XML_ParserFree(xpu->parser);
    xpu->parser = NULL;
    luaL_unref(L, LUA_REGISTRYINDEX, xpu->callbackRef);
  }

  return 0;
}

static const struct luaL_Reg lxp_methods[] = {
  {"parse", lxp_parse},
  {"close", lxp_close},
  {"__gc", lxp_close},
  {NULL, NULL}
};

static const struct luaL_Reg lxp_functions[] = {
  {"new", lxp_make_parser},
  {NULL, NULL}
};

int luaopen_lxp(lua_State *L) {
  luaL_newmetatable(L, "Expat");

  lua_pushvalue(L, -1);
  lua_setfield(L, -2, "__index");

  luaL_setfuncs(L, lxp_methods, 0);

  luaL_newlib(L, lxp_functions);

  return 1;
}
