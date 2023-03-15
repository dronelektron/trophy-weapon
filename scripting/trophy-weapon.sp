#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <clientprefs>

#include "morecolors"

#include "tw/cookie"
#include "tw/menu"
#include "tw/message"
#include "tw/use-case"
#include "tw/weapon"

#include "modules/console-variable.sp"
#include "modules/cookie.sp"
#include "modules/event.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/use-case.sp"
#include "modules/weapon.sp"

#define AUTO_CREATE_YES true
#define ROUND_RESPAWN_DETECTOR "round-respawn-detector"

public Plugin myinfo = {
    name = "Trophy weapon",
    author = "Dron-elektron",
    description = "Allows you to carry trophy weapon to the next round",
    version = "1.2.0",
    url = "https://github.com/dronelektron/trophy-weapon"
};

public void OnAllPluginsLoaded() {
    if (!LibraryExists(ROUND_RESPAWN_DETECTOR)) {
        SetFailState("Library '%s' is not found", ROUND_RESPAWN_DETECTOR);
    }
}

public void OnPluginStart() {
    Cookie_Create();
    Variable_Create();
    Event_Create();
    Weapon_Create();
    CookiesLateLoad();
    Menu_AddToPreferences();
    LoadTranslations("trophy-weapon.phrases");
    AutoExecConfig(AUTO_CREATE_YES, "trophy-weapon");
}

public void OnPluginEnd() {
    Weapon_Destroy();
}

public void OnClientConnected(int client) {
    Cookie_Reset(client);
    Weapon_ResetTrophy(client);
}

public void OnClientPutInServer(int client) {
    UseCase_HookWeaponDrop(client);
}

public void OnClientCookiesCached(int client) {
    Cookie_Load(client);
}

public void OnRoundRespawn() {
    UseCase_DisableTrophyWeapons();
}

void CookiesLateLoad() {
    for (int i = 1; i <= MaxClients; i++) {
        if (AreClientCookiesCached(i)) {
            OnClientCookiesCached(i);
        }
    }
}
