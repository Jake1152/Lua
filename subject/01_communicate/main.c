#include <stdio.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

int main() {
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    // Lua 파일을 실행
    if (luaL_dofile(L, "net_util.lua") != LUA_OK) {
        const char *error = lua_tostring(L, -1);
        printf("Error: %s\n", error);
        lua_close(L);
        return -1;
    }

    lua_close(L);
    return 0;
}
