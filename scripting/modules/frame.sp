void Frame_AskAboutTrophyWeapon(int client) {
    int userId = GetClientUserId(client);

    RequestFrame(OnAskAboutTrophyWeapon, userId);
}

void Frame_GiveTrophyWeapon(int client) {
    int userId = GetClientUserId(client);

    RequestFrame(OnGiveTrophyWeapon, userId);
}

static void OnAskAboutTrophyWeapon(int userId) {
    int client = GetClientOfUserId(userId);

    if (client > INVALID_CLIENT) {
        Menu_GiveTrophyWeapon(client);
    }
}

static void OnGiveTrophyWeapon(int userId) {
    int client = GetClientOfUserId(userId);

    if (client > INVALID_CLIENT) {
        UseCase_GiveTrophyWeapon(client);
    }
}
