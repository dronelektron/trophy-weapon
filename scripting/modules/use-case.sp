void UseCase_HookWeaponDrop(int client) {
    SDKHook(client, SDKHook_WeaponDropPost, UseCaseHook_WeaponDropPost);
}

public void UseCaseHook_WeaponDropPost(int client, int weapon) {
    Weapon_ResetTrophy(client);
}

void UseCase_EnableTrophyWeapons() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            SDKHook(client, SDKHook_WeaponEquipPost, Weapon_SetTrophy);
        }
    }
}

void UseCase_DisableTrophyWeapons() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            SDKUnhook(client, SDKHook_WeaponEquipPost, Weapon_SetTrophy);
        }
    }
}

void UseCase_GiveTrophyWeapons() {
    if (!Variable_PluginEnabled()) {
        return;
    }

    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            UseCase_GiveTrophy(client);
        }
    }
}

void UseCase_GiveTrophy(int client) {
    if (Weapon_IsTrophyExists(client) && IsPlayerAlive(client)) {
        Weapon_RemovePrimary(client);

        int weapon = Weapon_GiveTrophy(client);

        Weapon_GiveAmmo(client, weapon);
        Weapon_SetAsActive(client, weapon);
    }
}
