static Handle g_trophyModeCookie;
static char g_trophyMode[MAXPLAYERS + 1][COOKIE_TROPHY_MODE_SIZE];

void Cookie_Create() {
    g_trophyModeCookie = RegClientCookie("trophyweapon_mode", "Trophy weapon mode", CookieAccess_Private);
}

void Cookie_Load(int client) {
    char trophyMode[COOKIE_TROPHY_MODE_SIZE];

    GetClientCookie(client, g_trophyModeCookie, trophyMode, sizeof(trophyMode));

    if (trophyMode[0] == NULL_CHARACTER) {
        Cookie_SetTrophyMode(client, COOKIE_TROPHY_MODE_ASK);
    } else {
        Cookie_CopyValue(g_trophyMode[client], trophyMode);
    }
}

void Cookie_GetTrophyMode(int client, char[] mode) {
    Cookie_CopyValue(mode, g_trophyMode[client]);
}

void Cookie_SetTrophyMode(int client, const char[] trophyMode) {
    SetClientCookie(client, g_trophyModeCookie, trophyMode);
    Cookie_CopyValue(g_trophyMode[client], trophyMode);
}

static void Cookie_CopyValue(char[] destination, const char[] source) {
    strcopy(destination, COOKIE_TROPHY_MODE_SIZE, source);
}
