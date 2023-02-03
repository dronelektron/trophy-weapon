#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#include "tw/weapon"

#include "modules/console-variable.sp"
#include "modules/event.sp"
#include "modules/use-case.sp"
#include "modules/weapon.sp"

#define AUTO_CREATE_YES true
#define ROUND_RESPAWN_DETECTOR "round-respawn-detector"

public Plugin myinfo = {
    name = "Trophy weapon",
    author = "Dron-elektron",
    description = "Allows you to carry trophy weapon to the next round",
    version = "1.0.0",
    url = "https://github.com/dronelektron/trophy-weapon"
};

public void OnAllPluginsLoaded() {
    if (!LibraryExists(ROUND_RESPAWN_DETECTOR)) {
        SetFailState("Library '%s' is not found", ROUND_RESPAWN_DETECTOR);
    }
}

public void OnPluginStart() {
    Variable_Create();
    Event_Create();
    AutoExecConfig(AUTO_CREATE_YES, "trophy-weapon");
}

public void OnClientConnected(int client) {
    Weapon_ResetTrophy(client);
}

public void OnClientPutInServer(int client) {
    UseCase_HookWeaponDrop(client);
}

public void OnRoundRespawn() {
    UseCase_DisableTrophyWeapons();
}
