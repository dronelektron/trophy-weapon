void Message_YouPickedUpTrophyWeapon(int client, const char[] weaponName) {
    CPrintToChat(client, "%t%t", PREFIX_COLORED, "You picked up trophy weapon", weaponName);
}

void Message_NoTrophyWeapon(int client) {
    CPrintToChat(client, "%t%t", PREFIX_COLORED, "No trophy weapon");
}
