void Message_TrophyWeaponModeChanged(int client, const char[] phrase) {
    CPrintToChat(client, "%t%t", PREFIX_COLORED, "Trophy weapon mode changed", phrase);
}
