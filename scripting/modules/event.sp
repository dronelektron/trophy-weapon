void Event_Create() {
    HookEvent("player_team", OnResetTrophy);
    HookEvent("player_changeclass", OnResetTrophy);
    HookEvent("dod_round_start", OnRoundStart);
}

static void OnResetTrophy(Event event, const char[] name, bool dontBroadcast) {
    int userId = event.GetInt("userid");
    int client = GetClientOfUserId(userId);

    Client_Reset(client);
}

static void OnRoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_GiveTrophyWeapons();
}
