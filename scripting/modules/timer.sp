void Timer_AskAboutTrophyWeapon(int client) {
    int userId = GetClientUserId(client);

    CreateTimer(TIMER_DELAY, OnAskAboutTrophyWeapon, userId, TIMER_FLAGS);
}

static Action OnAskAboutTrophyWeapon(Handle timer, int userId) {
    int client = GetClientOfUserId(userId);

    if (client > INVALID_CLIENT) {
        Menu_GiveTrophyWeapon(client);
    }

    return Plugin_Continue;
}
