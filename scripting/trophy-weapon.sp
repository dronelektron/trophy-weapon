#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <clientprefs>

#include "trophy-weapon/cookie"
#include "trophy-weapon/menu"
#include "trophy-weapon/timer"
#include "trophy-weapon/use-case"
#include "trophy-weapon/weapon"

#include "modules/client.sp"
#include "modules/cookie.sp"
#include "modules/event.sp"
#include "modules/frame.sp"
#include "modules/hook.sp"
#include "modules/menu.sp"
#include "modules/timer.sp"
#include "modules/use-case.sp"
#include "modules/weapon.sp"

public Plugin myinfo = {
    name = "Trophy weapon",
    author = "Dron-elektron",
    description = "Allows you to carry trophy weapon to the next round",
    version = "1.4.2",
    url = "https://github.com/dronelektron/trophy-weapon"
};

public void OnPluginStart() {
    Cookie_Create();
    Event_Create();
    Menu_AddToPreferences();
    Weapon_Create();
    LateLoad();
    LoadTranslations("trophy-weapon.phrases");
}

public void OnClientConnected(int client) {
    Client_Reset(client);
}

public void OnClientPutInServer(int client) {
    Hook_WeaponEquipPost(client);
    Hook_WeaponDropPost(client);
}

public void OnClientCookiesCached(int client) {
    Cookie_Load(client);
}

static void LateLoad() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            LoadClient(client);
        }
    }
}

static void LoadClient(int client) {
    OnClientConnected(client);
    OnClientPutInServer(client);

    if (AreClientCookiesCached(client)) {
        OnClientCookiesCached(client);
    }
}
