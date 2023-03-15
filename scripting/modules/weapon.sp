static const char g_weaponClassName[][] = {
    "weapon_garand",
    "weapon_thompson",
    "weapon_bar",
    "weapon_spring",
    "weapon_30cal",
    "weapon_bazooka",
    "weapon_k98",
    "weapon_mp40",
    "weapon_mp44",
    "weapon_k98_scoped",
    "weapon_mg42",
    "weapon_pschreck"
};

static const int g_ammo[] = {80, 180, 240, 50, 300, 4, 60, 180, 180, 60, 250, 4};
static int g_trophyIndex[MAXPLAYERS + 1];
static StringMap g_weaponIndex = null;

void Weapon_Create() {
    g_weaponIndex = new StringMap();

    for (int i = 0; i < sizeof(g_weaponClassName); i++) {
        g_weaponIndex.SetValue(g_weaponClassName[i], i);
    }
}

void Weapon_Destroy() {
    delete g_weaponIndex;
}

bool Weapon_IsTrophyExists(int client) {
    return g_trophyIndex[client] != INDEX_NOT_FOUND;
}

void Weapon_ResetTrophy(int client) {
    g_trophyIndex[client] = INDEX_NOT_FOUND;
}

void Weapon_SetTrophy(int client, int weapon) {
    g_trophyIndex[client] = Weapon_GetIndex(weapon);
}

void Weapon_RemovePrimary(int client) {
    int weapon = Weapon_GetPrimary(client);

    if (weapon != WEAPON_NOT_FOUND) {
        RemovePlayerItem(client, weapon);
        RemoveEntity(weapon);
    }
}

int Weapon_GiveTrophy(int client) {
    int weaponIndex = g_trophyIndex[client];

    return GivePlayerItem(client, g_weaponClassName[weaponIndex]);
}

void Weapon_GiveAmmo(int client, int weapon) {
    int ammoTableOffset = FindSendPropInfo("CDODPlayer", "m_iAmmo");
    int ammoType = GetEntProp(weapon, Prop_Send, "m_iPrimaryAmmoType");
    int ammoOffset = ammoTableOffset + ammoType * AMMO_TYPE_SIZE;
    int weaponIndex = Weapon_GetIndex(weapon);
    int ammo = g_ammo[weaponIndex];

    SetEntData(client, ammoOffset, ammo, _, CHANGE_STATE_YES);
}

int Weapon_GetIndex(int weapon) {
    char weaponClassName[WEAPON_CLASS_NAME_SIZE];
    int index = INDEX_NOT_FOUND;

    GetEntityClassname(weapon, weaponClassName, sizeof(weaponClassName));

    g_weaponIndex.GetValue(weaponClassName, index);

    return index;
}

void Weapon_SetAsActive(int client, int weapon) {
    SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", weapon);
}

int Weapon_GetPrimary(int client) {
    return GetPlayerWeaponSlot(client, WEAPON_SLOT_PRIMARY);
}
