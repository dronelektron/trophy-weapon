void UseCase_OnWeaponEquipPost(int client, int weapon) {
    int trophyIndex = Client_GetTrophyIndex(client);
    int weaponIndex = Weapon_GetIndex(weapon);

    if (Weapon_IsPrimaryIndex(weaponIndex)) {
        Client_SetTrophyIndex(client, weaponIndex);

        if (trophyIndex != weaponIndex) {
            Client_SetPendingIndex(client, trophyIndex);
        }
    }
}

void UseCase_OnWeaponDropPost(int client, int weapon) {
    if (weapon == INDEX_NOT_FOUND) {
        return;
    }

    int index = Weapon_GetIndex(weapon);

    if (Weapon_IsPrimaryIndex(index)) {
        Client_Reset(client);
    }
}

void UseCase_GiveTrophyWeapons() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            UseCase_CheckTrophyWeaponMode(client);
        }
    }
}

void UseCase_GiveTrophyWeapon(int client) {
    if (IsTropyInvalid(client)) {
        return;
    }

    Weapon_GiveTrophy(client)
}

void UseCase_CheckTrophyWeaponMode(int client) {
    if (IsTropyInvalid(client)) {
        return;
    }

    char cookieValue[COOKIE_TROPHY_MODE_SIZE];

    Cookie_GetTrophyMode(client, cookieValue);

    if (strcmp(cookieValue, COOKIE_TROPHY_MODE_ASK) == 0) {
        Timer_AskAboutTrophyWeapon(client);
    } else if (strcmp(cookieValue, COOKIE_TROPHY_MODE_GIVE_ALWAYS) == 0) {
        Frame_GiveTrophyWeapon(client);
    }
}

static bool IsTropyInvalid(int client) {
    int index = Client_GetPendingIndex(client);

    return index == INDEX_NOT_FOUND;
}
