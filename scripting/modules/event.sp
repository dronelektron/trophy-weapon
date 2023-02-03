void Event_Create() {
    HookEvent("player_death", Event_ResetTrophy);
    HookEvent("player_team", Event_ResetTrophy);
    HookEvent("player_changeclass", Event_ResetTrophy);
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);
}

public void Event_ResetTrophy(Event event, const char[] name, bool dontBroadcast) {
    int userId = event.GetInt("userid");
    int client = GetClientOfUserId(userId);

    Weapon_ResetTrophy(client);
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_GiveTrophyWeapons();
}

public void Event_RoundWin(Event event, const char[] name, bool dontBroadcast) {
    UseCase_EnableTrophyWeapons();
}
