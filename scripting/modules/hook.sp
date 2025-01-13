void Hook_WeaponEquipPost(int client) {
    SDKHook(client, SDKHook_WeaponEquipPost, UseCase_OnWeaponEquipPost);
}

void Hook_WeaponDropPost(int client) {
    SDKHook(client, SDKHook_WeaponDropPost, UseCase_OnWeaponDropPost);
}
