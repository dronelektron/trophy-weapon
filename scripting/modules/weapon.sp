static const char g_weaponClassName[][] = {
    // Allies
    "weapon_garand",
    "weapon_thompson",
    "weapon_bar",
    "weapon_spring",
    "weapon_30cal",
    "weapon_bazooka",
    // Axis
    "weapon_k98",
    "weapon_mp40",
    "weapon_mp44",
    "weapon_k98_scoped",
    "weapon_mg42",
    "weapon_pschreck"
};

static const int g_ammo[] = {
    // Allies
    80,  // weapon_garand
    180, // weapon_thompson
    240, // weapon_bar
    50,  // weapon_spring
    300, // weapon_30cal
    4,   // weapon_bazooka
    // Axis
    60,  // weapon_k98
    180, // weapon_mp40
    180, // weapon_mp44
    60,  // weapon_k98_scoped
    250, // weapon_mg42
    4    // weapon_pschreck
};

static StringMap g_index;

void Weapon_Create() {
    g_index = new StringMap();

    for (int i = 0; i < sizeof(g_weaponClassName); i++) {
        g_index.SetValue(g_weaponClassName[i], i);
    }
}

int Weapon_GetIndex(int weapon) {
    char className[WEAPON_CLASS_NAME_SIZE];

    GetEntityClassname(weapon, className, sizeof(className));

    int index = INDEX_NOT_FOUND;

    g_index.GetValue(className, index);

    return index;
}

bool Weapon_IsPrimaryIndex(int index) {
    return index > INDEX_NOT_FOUND;
}

void Weapon_GiveTrophy(int client) {
    RemovePrimary(client);

    int index = Client_GetPendingIndex(client);
    int weapon = GivePlayerItem(client, g_weaponClassName[index]);

    SetAsActive(client, weapon);
    GiveAmmo(client, weapon);
}

static void RemovePrimary(int client) {
    int weapon = GetPlayerWeaponSlot(client, WEAPON_SLOT_PRIMARY);

    if (weapon > INDEX_NOT_FOUND) {
        RemovePlayerItem(client, weapon);
        RemoveEntity(weapon);
    }
}

static void SetAsActive(int client, int weapon) {
    SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", weapon);
}

static void GiveAmmo(int client, int weapon) {
    int index = Weapon_GetIndex(weapon);
    int ammoType = GetAmmoType(weapon);

    GivePlayerAmmo(client, g_ammo[index], ammoType);
}

static int GetAmmoType(int weapon) {
    return GetEntProp(weapon, Prop_Send, "m_iPrimaryAmmoType");
}
