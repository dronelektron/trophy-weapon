static ConVar g_pluginEnabled = null;

void Variable_Create() {
    g_pluginEnabled = CreateConVar("sm_trophyweapon_enable", "1", "Enable (1) or disable (0) plugin");
}

bool Variable_PluginEnabled() {
    return g_pluginEnabled.IntValue == 1;
}
