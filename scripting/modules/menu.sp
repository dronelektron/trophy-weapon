void Menu_AddToPreferences() {
    SetCookieMenuItem(MenuHandler_TrophyWeaponMode, 0, TROPHY_WEAPON);
}

public void MenuHandler_TrophyWeaponMode(int client, CookieMenuAction action, any info, char[] buffer, int maxLength) {
    if (action == CookieMenuAction_SelectOption) {
        Menu_Settings(client);
    } else {
        Format(buffer, maxLength, "%T", TROPHY_WEAPON, client);
    }
}

public void Menu_Settings(int client) {
    Menu menu = new Menu(MenuHandler_Settings);

    menu.SetTitle("%T", TROPHY_WEAPON, client);

    Menu_AddModeItem(menu, client, COOKIE_TROPHY_MODE_ASK, ITEM_ASK);
    Menu_AddModeItem(menu, client, COOKIE_TROPHY_MODE_GIVE_ALWAYS, ITEM_GIVE_ALWAYS);
    Menu_AddModeItem(menu, client, COOKIE_TROPHY_MODE_GIVE_NEVER, ITEM_GIVE_NEVER);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_Settings(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        Cookie_SetTrophyMode(param1, info);
        Menu_Settings(param1);
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        ShowCookieMenu(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_GiveTrophyWeapon(int client) {
    Menu menu = new Menu(MenuHandler_GiveTrophyWeapon);

    menu.SetTitle("%T", GIVE_TROPHY_WEAPON, client);

    Menu_AddAskItem(menu, ITEM_YES, client);
    Menu_AddAskItem(menu, ITEM_NO, client);

    menu.ExitButton = false;
    menu.Display(client, ASK_ABOUT_TROPHY_WEAPON_TIME);
}

public int MenuHandler_GiveTrophyWeapon(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, ITEM_YES)) {
            UseCase_GiveTrophyWeapon(param1);
        } else {
            Client_Reset(param1);
        }
    } else if (action == MenuAction_Cancel) {
        Client_Reset(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_AddAskItem(Menu menu, const char[] phrase, int client) {
    char item[ITEM_SIZE];

    Format(item, sizeof(item), "%T", phrase, client);

    menu.AddItem(phrase, item);
}

void Menu_AddModeItem(Menu menu, int client, const char[] mode, const char[] phrase) {
    char item[ITEM_SIZE];
    int style = Menu_GetItemStyleForMode(client, mode);

    SetGlobalTransTarget(client);
    Format(item, sizeof(item), "%t", phrase);

    menu.AddItem(mode, item, style);
}

int Menu_GetItemStyleForMode(int client, const char[] mode) {
    char trophyMode[COOKIE_TROPHY_MODE_SIZE];

    Cookie_GetTrophyMode(client, trophyMode);

    return strcmp(trophyMode, mode) == 0 ? ITEMDRAW_DISABLED : ITEMDRAW_DEFAULT;
}
