static Handle g_trophyWeaponCookie;
static char g_trophyWeaponMode[MAXPLAYERS + 1][COOKIE_VALUE_SIZE];

void Cookie_Create() {
    g_trophyWeaponCookie = RegClientCookie("trophyweapon_mode", "Trophy weapon mode", CookieAccess_Private);
}

void Cookie_Reset(int client) {
    g_trophyWeaponMode[client] = COOKIE_VALUE_ASK;
}

void Cookie_Load(int client) {
    char cookieValue[COOKIE_VALUE_SIZE];

    GetClientCookie(client, g_trophyWeaponCookie, cookieValue, sizeof(cookieValue));

    if (cookieValue[0] != NULL_CHARACTER) {
        Cookie_CopyValue(g_trophyWeaponMode[client], cookieValue);
    }
}

void Cookie_GetTrophyWeaponMode(int client, char[] mode) {
    Cookie_CopyValue(mode, g_trophyWeaponMode[client]);
}

void Cookie_SetTrophyWeaponMode(int client, const char[] mode) {
    Cookie_CopyValue(g_trophyWeaponMode[client], mode);
    SetClientCookie(client, g_trophyWeaponCookie, mode);
}

static void Cookie_CopyValue(char[] destination, const char[] source) {
    strcopy(destination, COOKIE_VALUE_SIZE, source);
}
