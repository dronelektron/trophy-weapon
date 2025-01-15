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

static const int g_ammoType[] = {
    // Allies
    4,  // weapon_garand
    8,  // weapon_thompson
    9,  // weapon_bar
    7,  // weapon_spring
    10, // weapon_30cal
    12, // weapon_bazooka
    // Axis
    5,  // weapon_k98
    8,  // weapon_mp40
    8,  // weapon_mp44
    5,  // weapon_k98_scoped
    11, // weapon_mg42
    12  // weapon_pschreck
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

void Weapon_GiveTrophy(int client, int index) {
    RemovePrimary(client);

    int weapon = GivePlayerItem(client, g_weaponClassName[index]);

    SetAsActive(client, weapon);
    GivePlayerAmmo(client, g_ammo[index], g_ammoType[index]);
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
