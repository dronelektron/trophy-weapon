void Frame_GiveTrophyWeapon(int client) {
    int userId = GetClientUserId(client);

    RequestFrame(OnGiveTrophyWeapon, userId);
}

static void OnGiveTrophyWeapon(int userId) {
    int client = GetClientOfUserId(userId);

    if (client > INVALID_CLIENT) {
        UseCase_GiveTrophyWeapon(client);
    }
}
