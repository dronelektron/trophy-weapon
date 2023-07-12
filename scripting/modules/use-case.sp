void UseCase_HookWeaponDrop(int client) {
    SDKHook(client, SDKHook_WeaponDropPost, UseCaseHook_WeaponDropPost);
}

public void UseCaseHook_WeaponDropPost(int client, int weapon) {
    if (UseCase_IsPrimaryWeapon(client, weapon)) {
        Weapon_ResetTrophy(client);
    }
}

void UseCase_EnableTrophyWeapons() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            SDKHook(client, SDKHook_WeaponEquipPost, UseCaseHook_SetTrophyWeapon);
        }
    }
}

void UseCase_DisableTrophyWeapons() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            SDKUnhook(client, SDKHook_WeaponEquipPost, UseCaseHook_SetTrophyWeapon);
        }
    }
}

void UseCaseHook_SetTrophyWeapon(int client, int weapon) {
    if (!UseCase_IsPrimaryWeapon(client, weapon)) {
        return;
    }

    if (UseCase_IsTrophyWeapon(client, weapon)) {
        Weapon_SetTrophy(client, weapon);
    } else {
        Weapon_ResetTrophy(client);
    }
}

bool UseCase_IsPrimaryWeapon(int client, int weapon) {
    return Weapon_GetPrimary(client) == weapon;
}

bool UseCase_IsTrophyWeapon(int client, int weapon) {
    int team = GetClientTeam(client);
    int class = GetEntProp(client, Prop_Send, "m_iDesiredPlayerClass");
    int defaultWeaponOffset = (team - TEAM_ALLIES) * CLASSES_AMOUNT + class;
    int weaponIndex = Weapon_GetIndex(weapon);

    return weaponIndex != defaultWeaponOffset;
}

void UseCase_GiveTrophyWeapons() {
    if (!Variable_PluginEnabled()) {
        return;
    }

    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            UseCase_CheckTrophyWeaponMode(client);
        }
    }
}

void UseCase_CheckTrophyWeaponMode(int client) {
    char cookieValue[COOKIE_TROPHY_MODE_SIZE];

    Cookie_GetTrophyMode(client, cookieValue);

    if (strcmp(cookieValue, COOKIE_TROPHY_MODE_ASK) == 0) {
        UseCase_AskForTrophyWeaponDelayed(client);
    } else if (strcmp(cookieValue, COOKIE_TROPHY_MODE_GIVE_ALWAYS) == 0) {
        UseCase_GiveTrophyWeaponDelayed(client);
    }
}

void UseCase_AskForTrophyWeaponDelayed(int client) {
    if (Weapon_IsTrophyExists(client) && IsPlayerAlive(client)) {
        int userId = GetClientUserId(client);

        CreateTimer(TIMER_GIVE_TROPHY_WEAPON_DELAY, UseCaseTimer_AskForTrophyWeapon, userId, TIMER_GIVE_TROPHY_WEAPON_FLAGS);
    }
}

public Action UseCaseTimer_AskForTrophyWeapon(Handle timer, int userId) {
    int client = GetClientOfUserId(userId);

    if (client != INVALID_CLIENT) {
        Menu_GiveTrophyWeapon(client);
    }

    return Plugin_Continue;
}

void UseCase_GiveTrophyWeaponDelayed(int client) {
    int userId = GetClientUserId(client);

    CreateTimer(TIMER_GIVE_TROPHY_WEAPON_DELAY, UseCaseTimer_GiveTrophyWeapon, userId, TIMER_GIVE_TROPHY_WEAPON_FLAGS);
}

public Action UseCaseTimer_GiveTrophyWeapon(Handle timer, int userId) {
    int client = GetClientOfUserId(userId);

    if (client != INVALID_CLIENT) {
        UseCase_GiveTrophyWeapon(client);
    }

    return Plugin_Continue;
}

void UseCase_GiveTrophyWeapon(int client) {
    if (Weapon_IsTrophyExists(client)) {
        Weapon_RemovePrimary(client);

        int weapon = Weapon_GiveTrophy(client);

        Weapon_GiveAmmo(client, weapon);
        Weapon_SetAsActive(client, weapon);
    }
}
