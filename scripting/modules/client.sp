static int g_trophyIndex[MAXPLAYERS + 1];
static int g_pendingIndex[MAXPLAYERS + 1];

void Client_Reset(int client) {
    g_trophyIndex[client] = INDEX_NOT_FOUND;
    g_pendingIndex[client] = INDEX_NOT_FOUND;
}

int Client_GetTrophyIndex(int client) {
    return g_trophyIndex[client];
}

void Client_SetTrophyIndex(int client, int index) {
    g_trophyIndex[client] = index;
}

int Client_GetPendingIndex(int client) {
    return g_pendingIndex[client];
}

void Client_SetPendingIndex(int client, int index) {
    g_pendingIndex[client] = index;
}
